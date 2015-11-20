//
//  InitialView.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import <UIKit/UIKit.h>

@interface InitialView : UIView

- (void)updateLocationButton:(BOOL)tracking;
- (void)setEmptyStateVisible:(BOOL)visible;
- (void)setInstructionsVisible:(BOOL)visible;

@end
