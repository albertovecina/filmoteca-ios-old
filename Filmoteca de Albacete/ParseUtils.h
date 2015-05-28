//
//  ParseUtils.h
//  Filmoteca de Albacete
//
//  Created by Alberto Vecina Sánchez on 19/3/15.
//  Copyright (c) 2015 VSA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseUtils : NSObject

+ (NSString*) downloadHTML: (NSString*) urlSring;
+ (NSMutableArray*) parseMoviesList: (NSString*) source;
+ (NSString*) parseDetail: (NSString*) sourceHTML;

@end
