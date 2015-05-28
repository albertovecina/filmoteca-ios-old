//
//  DetailViewController.h
//  Filmoteca de Albacete
//
//  Created by Alberto Vecina Sánchez on 24/5/15.
//  Copyright (c) 2015 VSA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController

@property Movie *movie;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
