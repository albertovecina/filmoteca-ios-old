//
//  ParseUtils.m
//  Filmoteca de Albacete
//
//  Created by Alberto Vecina Sánchez on 19/3/15.
//  Copyright (c) 2015 VSA. All rights reserved.
//

#import "ParseUtils.h"

@implementation ParseUtils

+ (NSString*) loadHTML: (NSString*) urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSError *error = nil;
    NSString *locationString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];

    NSLog(@"ERROR: %@", [error description]);
    return locationString;
}

@end
