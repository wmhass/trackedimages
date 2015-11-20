//
//  InitialViewControllerPresenter.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import <Foundation/Foundation.h>

@interface InitialViewControllerPresenter : NSObject

@property (nonatomic) BOOL isTracking;

- (void)toggleTrackLocation;

@end
