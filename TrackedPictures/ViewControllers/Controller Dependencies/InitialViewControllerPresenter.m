//
//  InitialViewControllerPresenter.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "InitialViewControllerPresenter.h"
#import "CustomLocationManager.h"
#import "InitialViewInteractor.h"

@interface InitialViewControllerPresenter() <CustomLocationManagerDelegate, InitialViewInteractorDelegate>

@property (strong, nonatomic) CustomLocationManager *locationManager;
@property (strong, nonatomic) InitialViewInteractor *interactor;

@end

@implementation InitialViewControllerPresenter

#pragma mark - Intializers

- (id)init {
    self = [super init];
    if (self) {
        [self initLocationManager];
        [self initInteractor];
    }
    return self;
}


#pragma mark - Private

- (void)initInteractor {
    self.interactor = [[InitialViewInteractor alloc] init];
    self.interactor.delegate = self;
}

- (void)initLocationManager {
    self.locationManager = [[CustomLocationManager alloc] init];
    self.locationManager.achievemntLocationDelegate = self;
}

- (void)updateLocationServices {
    if (self.isTracking) {
        [self.locationManager startTracking];
        [self notifyDelegateStartTracking];
    } else {
        [self.locationManager stopTracking];
        [self notifyDelegateStopTracking];
    }
}

- (void)checkInteractorCanLoadData {
    if(self.isTracking && ![self.interactor hasConnectionToRequestImages]) {
        if([self.delegate respondsToSelector:@selector(initialViewControllerPresenter:errorOccurredLoadingPictures:)]) {
            [self.delegate initialViewControllerPresenter:self errorOccurredLoadingPictures:NSLocalizedString(@"NO_CONNECTION_ERROR", nil)];
        }
    }
}

- (void)notifyDelegateStopTracking {
    if([self.delegate respondsToSelector:@selector(initialViewControllerPresenterDidStopTracking:)]) {
        [self.delegate initialViewControllerPresenterDidStopTracking:self];
    }
}

- (void)notifyDelegateStartTracking {
    if([self.delegate respondsToSelector:@selector(initialViewControllerPresenterDidStartTracking:)]) {
        [self.delegate initialViewControllerPresenterDidStartTracking:self];
    }
}

#pragma mark - Public

- (void)toggleTrackLocation {
    self.isTracking = !self.isTracking;
    [self updateLocationServices];
    [self checkInteractorCanLoadData];
}

@end


/**
 * @discussion This is a Swift like implementation: Implementing protocols in separated extensions(categories) makes the code more clear
 */
#pragma mark - CustomLocationManagerDelegate

@interface InitialViewControllerPresenter(CustomLocationManagerDelegate)
@end

@implementation InitialViewControllerPresenter(CustomLocationManagerDelegate)


- (void)desiredLocationAchievedForLocationManager:(CustomLocationManager *)locationManager withLocation:(CLLocation *)location {
    [self.interactor requestImagesForLocation:location];
}

@end


#pragma mark - InitialViewInteractorDelegate

@interface InitialViewControllerPresenter(InitialViewInteractorDelegate)
@end

@implementation InitialViewControllerPresenter(InitialViewInteractorDelegate)

- (void)initialViewInteractor:(InitialViewInteractor *)interactor didLoadImages:(NSArray *)images {
    if(self.isTracking && [self.delegate respondsToSelector:@selector(initialViewControllerPresenter:loadedPictures:)]) {
        [self.delegate initialViewControllerPresenter:self loadedPictures:images];
    }
}

- (void)initialViewInteractor:(InitialViewInteractor *)interactor errorLoadingImages:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(initialViewControllerPresenter:errorOccurredLoadingPictures:)]) {
        [self.delegate initialViewControllerPresenter:self errorOccurredLoadingPictures:error.localizedDescription];
    }
}

@end
