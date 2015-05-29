//
//  ProgressAlert.m
//  Filmoteca de Albacete
//
//  Created by Alberto Vecina Sánchez on 28/5/15.
//  Copyright (c) 2015 VSA. All rights reserved.
//

#import "ProgressAlert.h"
#import "UIColors.h"
#import "SVProgressHUD.h"

@implementation ProgressAlert

+ (void) showProgress
{
    [SVProgressHUD setBackgroundColor:[UIColors colorFromHexString: COLOR_PRIMARY]];
    [SVProgressHUD setForegroundColor:[UIColors colorFromHexString: COLOR_WHITE]];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"LoadingAlert", @"Loading message")];
}

+ (void) hideProgress
{
    [SVProgressHUD dismiss];
}

@end
