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

- (NSString*)saveAction:(NSDictionary *)data
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"storage"];
    
    return @"";
}

- (NSString*)loadAction:(NSDictionary *)data
{
    id storage = [[NSUserDefaults standardUserDefaults] objectForKey:@"storage"];
    
    if (storage == nil) {
        
        return @"";
    }
    
    NSError *error;
    NSData *json = [NSJSONSerialization
                    dataWithJSONObject:storage
                    options:0
                    error:&error];
    
    return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}

- (NSString*)notifyAction:(NSDictionary *)data
{
    NSLog(@"Notified!");
    
    return @"";
}

@end
