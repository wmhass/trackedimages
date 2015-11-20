//
//  AppTheme.m
//  
//
//  Created by William Hass on 11/20/15.
//
//

#import "AppTheme.h"

@implementation AppTheme

+ (UIColor *)baseColor {
    return [[UIColor redColor] colorWithAlphaComponent:0.6];
}

+ (UIColor *)textBaseColor {
    return [UIColor whiteColor];
}

+ (UIColor *)lightGrayText {
    return [[UIColor blackColor] colorWithAlphaComponent:0.3];
}

+ (UIColor *)activeColor {
    return [[UIColor greenColor] colorWithAlphaComponent:0.7];
}

+ (UIColor *)tableHeaderColor {
    return [[UIColor grayColor] colorWithAlphaComponent:0.1];
}

@end
