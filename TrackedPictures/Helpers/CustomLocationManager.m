//
//  CustomLocationManager.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "CustomLocationManager.h"

const float CustomLocationManagerDistanceFilter = 100.0;

@interface CustomLocationManager() <CLLocationManagerDelegate>

@end

@implementation CustomLocationManager

#pragma mark - Initializers

- (id)init {
    self = [super init];
    if(self) {
        self.distanceFilter = CustomLocationManagerDistanceFilter;
        self.desiredAccuracy = kCLLocationAccuracyBest;
        self.delegate = self;
    }
    return self;
}

#pragma mark - Public

- (void)startTracking {
    [self requestAlwaysAuthorization];
    [self startUpdatingLocation];
}

- (void)stopTracking {
    [self stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    if ([self.achievemntLocationDelegate respondsToSelector:@selector(desiredLocationAchievedForLocationManager:withLocation:)]) {
        [self.achievemntLocationDelegate desiredLocationAchievedForLocationManager:self withLocation:[locations lastObject]];
    }
}


@end
