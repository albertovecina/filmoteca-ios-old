//
//  DetailViewController.m
//  Filmoteca de Albacete
//
//  Created by Alberto Vecina Sánchez on 24/5/15.
//  Copyright (c) 2015 VSA. All rights reserved.
//

#import "DetailViewController.h"
#import "ParseUtils.h"
#import "AFNetworking.h"
#import "ParseUtils.h"
#import "ProgressAlert.h"

@interface DetailViewController ()
    @property(strong, nonatomic) NSMutableData *requestData;
@end

@implementation DetailViewController

@synthesize movie;

- (void)viewDidLoad
{
    self.requestData = [[NSMutableData alloc]init];
    /*NSString *html = [ParseUtils downloadHTML:movie.url];
    NSURL *url = [NSURL URLWithString:movie.url];
    [self.webView loadHTMLString:html baseURL:url];*/
    
    [ProgressAlert showProgress];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:movie.url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *parsedHTML = [ParseUtils parseDetail:responseString];
        NSURL *url = [NSURL URLWithString:movie.url];
        [self.webView loadHTMLString:parsedHTML baseURL:url];
        [ProgressAlert hideProgress];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
