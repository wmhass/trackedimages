//
//  InitialViewControllerPresenter.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import <Foundation/Foundation.h>

@class InitialViewControllerPresenter;
@protocol InitialViewControllerPresenterDelegate <NSObject>

@optional
- (void)initialViewControllerPresenter:(InitialViewControllerPresenter *)presenter loadedPictures:(NSArray *)pictures;
- (void)initialViewControllerPresenter:(InitialViewControllerPresenter *)presenter errorOccurredLoadingPictures:(NSString *)errorMessage;
- (void)initialViewControllerPresenterDidStopTracking:(InitialViewControllerPresenter *)presenter;
- (void)initialViewControllerPresenterDidStartTracking:(InitialViewControllerPresenter *)presenter;
@end

@interface InitialViewControllerPresenter : NSObject

@property (weak, nonatomic) id<InitialViewControllerPresenterDelegate> delegate;
@property (nonatomic) BOOL isTracking;

- (void)toggleTrackLocation;

@end
