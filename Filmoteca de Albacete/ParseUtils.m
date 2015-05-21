//
//  ParseUtils.m
//  Filmoteca de Albacete
//
//  Created by Alberto Vecina Sánchez on 19/3/15.
//  Copyright (c) 2015 VSA. All rights reserved.
//

#import "ParseUtils.h"
#import "Movie.h"
#import <HTMLReader/HTMLReader.h>

@implementation ParseUtils

NSString *const CLASS_EVENT = @".contenttype-evento";
NSString *const CLASS_DATE = @".description";

+ (NSString*) loadHTML: (NSString*) urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSError *error = nil;
    NSString *locationString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];

    NSLog(@"ERROR: %@", [error description]);
    return locationString;
}

+ (NSMutableArray*) getMoviesList: (NSString*) source {
    HTMLDocument *document = [HTMLDocument documentWithString:source];
    NSArray *htmlElementArrayEvents = [document nodesMatchingSelector: CLASS_EVENT];
    NSArray *htmlElementArrayDates = [document nodesMatchingSelector: CLASS_DATE];

    NSMutableArray *moviesList = [[NSMutableArray alloc] init];

    for(int x = 0; x < [htmlElementArrayEvents count]; x++) {
        
        Movie *movie = [[Movie alloc]init];
        
        HTMLElement *item = htmlElementArrayEvents[x];
        NSString *text = item.textContent;
        NSString *newReplacedString = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *trimmedString = [newReplacedString stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        movie.title = [[trimmedString componentsSeparatedByString:@"("] objectAtIndex:0];
        movie.date = [htmlElementArrayDates[x] textContent];

        [moviesList addObject:movie];
    }
    return moviesList;
}

@end

