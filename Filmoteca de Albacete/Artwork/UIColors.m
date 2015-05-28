//
//  UIColors.m
//  Filmoteca de Albacete
//
//  Created by Alberto Vecina Sánchez on 28/5/15.
//  Copyright (c) 2015 VSA. All rights reserved.
//

#import "UIColors.h"

@implementation UIColors

NSString *const COLOR_PRIMARY = @"#EF6C00";
NSString *const COLOR_PRIMARY_DARK = @"#E65100";
NSString *const COLOR_ACCENT = @"#FFE0B2";
NSString *const COLOR_SELECTED = @"#FFF3E0";
NSString *const COLOR_WHITE = @"#FFFFFF";

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
