//
//  PanoramioPictureTableViewCell+PanoramioPicture.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "PanoramioPictureTableViewCell+PanoramioPicture.h"
#import "PanoramioPicture.h"
#import "PanoramioPictureOwner.h"

@implementation PanoramioPictureTableViewCell (PanoramioPicture)

- (void)layoutWithPicture:(PanoramioPicture *)picture {
    
    NSString *title = picture.title;
    NSString *ownerName = picture.owner.name;
    NSString *dateString = @"";
    
    if(picture.uploadDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd MMMM yyyy";
        dateString = [dateFormatter stringFromDate:picture.uploadDate];
    }
    
    [self configureWithImageURL:picture.fileURL titile:title ownerName:ownerName date:dateString];
}

@end
