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
    } else {
        [self.locationManager stopTracking];
    }
}


#pragma mark - Public

- (void)toggleTrackLocation {
    self.isTracking = !self.isTracking;
    [self updateLocationServices];
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
    
}

- (void)initialViewInteractor:(InitialViewInteractor *)interactor errorLoadingImages:(NSError *)error {
    
}

@end
