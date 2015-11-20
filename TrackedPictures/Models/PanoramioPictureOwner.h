//
//  PanoramioPictureOwner.h
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import <Foundation/Foundation.h>

@interface PanoramioPictureOwner : NSObject

@property (strong, nonatomic) NSNumber *ownerID;
@property (strong, nonatomic) NSString *ownerName;
@property (strong, nonatomic) NSURL *ownerURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
