//
//  CustomLocationManager.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import <CoreLocation/CoreLocation.h>

@class CustomLocationManager, CLLocation;
@protocol CustomLocationManagerDelegate <NSObject>

@optional
- (void)desiredLocationAchievedForLocationManager:(CustomLocationManager *)locationManager withLocation:(CLLocation *)location;

@end

@interface CustomLocationManager : CLLocationManager

@property (weak, nonatomic) id<CustomLocationManagerDelegate> achievemntLocationDelegate;

- (void)startTracking;
- (void)stopTracking;

@end
