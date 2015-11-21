//
//  PanoramioPictureTableViewCell.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import <UIKit/UIKit.h>

extern NSString * const PanoramioPictureTableViewCellReuseIdentifier;
extern NSString * const PanoramioPictureTableViewCellNibName;

@interface PanoramioPictureTableViewCell : UITableViewCell

- (void)configureWithImageURL:(NSURL *)imageURL titile:(NSString *)title ownerName:(NSString *)ownerName date:(NSString *)date;
- (CGFloat)contentHeight;

@end
