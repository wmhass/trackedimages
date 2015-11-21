//
//  InitialViewInteractor.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "InitialViewInteractor.h"
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "PanoramioPicture.h"
#import "PanoramioPictureOwner.h"

@implementation InitialViewInteractor

#pragma mark - Initializers

- (id)init {
    self = [super init];
    if(self) {
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return self;
}


#pragma mark - Public

- (void)requestImagesForLocation:(CLLocation *)location {
    if(![self hasConnectionToRequestImages]) {
        return;
    }
    static dispatch_queue_t requestQueue = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestQueue = dispatch_queue_create("com.TrackedPictures.DownloadPicturesQueue", DISPATCH_QUEUE_SERIAL);
    });
    
    __weak InitialViewInteractor *weakSelf = self;
    dispatch_async(requestQueue, ^{
        [weakSelf executeRequestForLocation:location];
    });
}

- (BOOL)hasConnectionToRequestImages {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

#pragma mark - Private

+ (NSString *)urlForLocation:(CLLocation *)location {
    
    return [NSString stringWithFormat:@"http://www.panoramio.com/map/get_panoramas.php?set=public&from=0&to=20&minx=%.10f&miny=%.10f&maxx=%.10f&maxy=%.10f&size=medium&mapfilter=true",location.coordinate.longitude,location.coordinate.latitude, location.coordinate.longitude+0.001,location.coordinate.latitude+0.001];
}

- (void)executeRequestForLocation:(CLLocation *)location {
    
    NSString *urlString = [InitialViewInteractor urlForLocation:location];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    __weak InitialViewInteractor *weakSelf = self;
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [weakSelf notifyDelegateErrorOccured:error];
            } else {
                [weakSelf fetchSuccessResponse:responseObject];
            }
        });
    }];
    [dataTask resume];
}

- (void)notifyDelegateErrorOccured:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(initialViewInteractor:errorLoadingImages:)]) {
        [self.delegate initialViewInteractor:self errorLoadingImages:error];
    }
}

- (void)notifyDelegateFotosLoaded:(NSArray *)photos {
    if([self.delegate respondsToSelector:@selector(initialViewInteractor:didLoadImages:)]) {
        [self.delegate initialViewInteractor:self didLoadImages:photos];
    }
}

- (void)fetchSuccessResponse:(id)responseData {
    
    NSMutableArray *pictures = [[NSMutableArray alloc] initWithCapacity:[responseData[@"count"] integerValue]];
    
    for (NSDictionary *photo in responseData[@"photos"]) {
        
        PanoramioPictureOwner *owner = [[PanoramioPictureOwner alloc] initWithDictionary:photo];
        PanoramioPicture *picture = [[PanoramioPicture alloc] initWithDictionary:photo];
        picture.owner = owner;
        
        [pictures addObject:picture];
    }
    
    [self notifyDelegateFotosLoaded:[NSArray arrayWithArray:pictures]];
}

@end
