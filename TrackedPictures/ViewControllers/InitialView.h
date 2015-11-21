//
//  InitialView.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InitialViewMode) {
    InitialViewEmptyNotTrackingMode = 0,
    InitialViewEmptyTrackingMode,
    InitialViewNotEmptyTracking
};

@interface InitialView : UIView

@property (nonatomic) InitialViewMode mode;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
