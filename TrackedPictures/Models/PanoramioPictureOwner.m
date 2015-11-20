//
//  PanoramioPictureOwner.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "PanoramioPictureOwner.h"

@implementation PanoramioPictureOwner

- (id)initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        _ownerID = dictionary[@"owner_id"];
        _name = dictionary[@"owner_name"];
        
        NSString *stringURL = dictionary[@"owner_url"];
        if(stringURL.length > 0) {
            _URL = [NSURL URLWithString:stringURL];
        }
    }
    return self;
}

@end
