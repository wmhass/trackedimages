//
//  InitialViewInteractor.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import <Foundation/Foundation.h>

@class CLLocation, InitialViewInteractor;

@protocol InitialViewInteractorDelegate <NSObject>

@optional
- (void)initialViewInteractor:(InitialViewInteractor *)interactor didLoadImages:(NSArray *)images;
- (void)initialViewInteractor:(InitialViewInteractor *)interactor errorLoadingImages:(NSError *)error;

@end

@interface InitialViewInteractor : NSObject

@property (weak, nonatomic) id<InitialViewInteractorDelegate> delegate;

- (void)requestImagesForLocation:(CLLocation *)location;
- (BOOL)hasConnectionToRequestImages;

@end
