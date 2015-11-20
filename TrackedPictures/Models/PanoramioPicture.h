//
//  PanoramioPicture.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import <Foundation/Foundation.h>

@class PanoramioPictureOwner;
@interface PanoramioPicture : NSObject

@property (strong, nonatomic) NSNumber *photoID;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *width;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *URL;
@property (strong, nonatomic) NSURL *fileURL;
@property (strong, nonatomic) NSDate *uploadDate;
@property (strong, nonatomic) PanoramioPictureOwner *owner;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
