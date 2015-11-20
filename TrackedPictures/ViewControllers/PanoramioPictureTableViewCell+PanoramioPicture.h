//
//  PanoramioPictureTableViewCell+PanoramioPicture.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "PanoramioPictureTableViewCell.h"
@class PanoramioPicture;
@interface PanoramioPictureTableViewCell (PanoramioPicture)

- (void)layoutWithPicture:(PanoramioPicture *)picture;

@end
