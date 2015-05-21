//
//  PruebaStatic.m
//  Filmoteca de Albacete
//
//  Created by Alberto Vecina Sánchez on 6/3/15.
//  Copyright (c) 2015 VSA. All rights reserved.
//

#import "PruebaStatic.h"

@implementation PruebaStatic

+(NSString*)hail:(NSString*) saludo{
    NSURL *url = [NSURL URLWithString:saludo];
    NSError *errorDeMierda = nil;
    NSString *htmlContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&errorDeMierda];
    return htmlContent;
}

@end
