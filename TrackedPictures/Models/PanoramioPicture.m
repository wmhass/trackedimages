//
//  PanoramioPicture.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "PanoramioPicture.h"

@implementation PanoramioPicture

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _photoID = dictionary[@"photo_id"];
        _title = dictionary[@"photo_title"];
        _longitude = @([dictionary[@"longitude"] doubleValue]);
        _latitude = @([dictionary[@"latitude"] doubleValue]);
        _width = @([dictionary[@"width"] floatValue]);
        _height = @([dictionary[@"height"] floatValue]);

        NSString *stringPhotoURL = dictionary[@"photo_url"];
        if(stringPhotoURL.length > 0) {
            _URL = [NSURL URLWithString:stringPhotoURL];
        }
        
        NSString *stringFileURL = dictionary[@"photo_file_url"];
        if(stringFileURL.length > 0) {
            _fileURL = [NSURL URLWithString:stringFileURL];
        }
        
        NSString *uploadStringDate = dictionary[@"upload_date"];
        if(uploadStringDate.length > 0) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"dd MMMM yyyy";
            _uploadDate = [dateFormatter dateFromString:uploadStringDate];
        }
    }
    return self;
}

@end
