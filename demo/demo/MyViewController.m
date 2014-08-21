//
//  MyViewController.m
//  demo
//
//  Created by Eduardo García Sanz on 21/08/14.
//  Copyright (c) 2014 Comakai. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  prepareWebView];
    [self  loadHTML];
}

- (void)prepareWebView
{
    webView.delegate = self;
}

- (void)loadHTML
{
    NSURL *htmlPath = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                              pathForResource:@"app"
                                              ofType:@"html"
                                              inDirectory:@"web"]];
    
    [webView loadRequest:[NSURLRequest requestWithURL:htmlPath]];
}

- (void)saveAction:(NSDictionary *)data
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"storage"];
}

- (NSData*)loadAction:(NSDictionary *)data
{
    id storage = [[NSUserDefaults standardUserDefaults] objectForKey:@"storage"];
    
    if (storage == nil) {
        
        return nil;
    }
    
    NSError *error;
    NSData *response = [NSJSONSerialization
                    dataWithJSONObject:storage
                    options:0
                    error:&error];
    
    return response;
}

- (void)notifyAction:(NSDictionary *)data
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This is coming..."
                                                    message:@"FROM THE OTHER SIDE"
                                                   delegate:self
                                          cancelButtonTitle:@"Cool!!!"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
