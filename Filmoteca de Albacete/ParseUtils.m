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
NSString *const CLASS_URL = @".url";
NSString *const ATTR_HREF = @"href";

/**** DETAIL PAGE ***/

NSString *const STYLE = {
@"<style type=\"text/css\">"
    @"img, input{ max-width:100%!important; height:auto!important;} strong{font-size:13px;} "
    @"a{font-size:15px!important;"
    @"word-wrap: break-word; /* Internet Explorer 5.5+ */ "
    @"}"
    @"p{text-align:center;}"
    @".documentDescription{font-weight:bold;color:#000000; text-align:center;}"
    @".tablaeventos table{ width:100%!important;}"
    @".tablaeventos td{width:50%!important;}"
    @"a {color:#000000; font-weight:bold;}"
    @".vevent{font-size:15px!important; color:#5f5c5c;}"
    @"td{ font-size:15px!important;line-height:18px; vertical-align:top;}"
    @"table{border:1px solid #848484;}"
    @"dd{ margin: 8px 5px 8px 105px;"
    @"color: rgb(51, 51, 51); "
    @"font-size: 14px; line-height: 18px; font-family: Arial, sans-serif; font-style: normal;"
    @"font-variant: normal; font-weight: normal; letter-spacing: normal; "
    @"orphans: auto; text-align: start; text-indent: 0px; text-transform: none; "
    @"white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; "
    @"background-color: rgb(255, 255, 255); "
    @"}"
    @"th{float:left!important;font-size:13px!important;}"
@"</style>"};

NSString *const CLASS_TABLAEVENTOS = @".tablaeventos";
NSString *const CLASS_VEVENT = @".vevent";

NSString *const TAG_DD = @"dd";
NSString *const TAG_A = @"a";
NSString *const TAG_IMG = @"img";

NSString *const ATTR_STYLE = @"style";

+ (NSString*) downloadHTML: (NSString*) urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSError *error = nil;
    NSString *locationString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];

    NSLog(@"ERROR: %@", [error description]);
    return locationString;
}

+ (NSMutableArray*) parseMoviesList: (NSString*) source {
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
        
        HTMLElement *link = [item nodesMatchingSelector: CLASS_URL].firstObject;
        
        movie.url = [link.attributes objectForKey:ATTR_HREF ];
        
        [moviesList addObject:movie];
    }
    return moviesList;
}

+ (NSString*) parseDetail: (NSString*) source {
    
    HTMLDocument *document = [HTMLDocument documentWithString:source];
    NSArray *ddElements = [document nodesMatchingSelector:TAG_DD];
    for(HTMLElement *ddElement in ddElements)
        [ddElement removeAttributeWithName: ATTR_STYLE];
    NSArray *aElements = [document nodesMatchingSelector:TAG_A];
    for(HTMLElement *aElement in aElements)
        [aElement removeAttributeWithName:ATTR_HREF];
    
    HTMLElement *vevent = [document firstNodeMatchingSelector:CLASS_VEVENT];
    HTMLElement *tablaEventos = [vevent firstNodeMatchingSelector:CLASS_TABLAEVENTOS];
    NSArray *tablaEventosImages = [tablaEventos nodesMatchingSelector:TAG_IMG];
    for(HTMLNode *tablaEventosImage in tablaEventosImages)
        [tablaEventosImage removeFromParentNode];
    
    /*if( tablaEventos != nil) {
        NSMutableOrderedSet* chilren = [[vevent parentNode] mutableChildren];
        //[vevent insertString:[tablaEventos textContent] atChildNodeIndex:0];
    }*/
    
    return [STYLE stringByAppendingString:[vevent innerHTML]];
}

/*
 Document document = Jsoup.parse(source);
 document.getElementsByTag("dd").removeAttr("style");
 document.getElementsByTag("a").removeAttr("href");
 
 Element vevent = document.getElementsByClass(CLASS_VEVENT).first();
 
 if(vevent.getElementsByClass(CLASS_TABLAEVENTOS).isEmpty()) {
 Element tablaeventos = document.getElementsByClass(CLASS_TABLAEVENTOS).first();
 if(tablaeventos != null) {
 List<Node> nodesToInsert = new ArrayList<Node>();
 nodesToInsert.add((Node) tablaeventos);
 vevent = vevent.insertChildren(vevent.childNodeSize(), nodesToInsert);
 }
 }
 
 return style + vevent.html();
 }
 */

@end

