//
//  UIColors.h
//  Filmoteca de Albacete
//
//  Created by Alberto Vecina Sánchez on 28/5/15.
//  Copyright (c) 2015 VSA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColors : UIViewController

extern NSString *const COLOR_PRIMARY;
extern NSString *const COLOR_PRIMARY_DARK;
extern NSString *const COLOR_ACCENT;
extern NSString *const COLOR_SELECTED;
extern NSString *const COLOR_WHITE;

+ (UIColor *)colorFromHexString:(NSString *)hexString;


@end
