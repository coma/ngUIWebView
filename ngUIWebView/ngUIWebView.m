#import "ngUIWebView.h"

@interface ngUIWebView ()

@end

@implementation ngUIWebView
- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *url = [[request URL] absoluteString];
    
    NSLog(@"%@", url);
    
    if ([url hasPrefix:@"nguiwv://"]) {
        
        NSString *action;
        NSError  *error;
        NSString *identifier = [url substringFromIndex:9];
        NSString *call       = [NSString stringWithFormat:@"nguiwv.request(%@);", identifier];
        NSString *raw        = [wv stringByEvaluatingJavaScriptFromString:call];
        
        NSDictionary *json   = [NSJSONSerialization
                                JSONObjectWithData:[raw dataUsingEncoding:NSUTF8StringEncoding]
                                options:kNilOptions
                                error:&error];
        
        NSString     *method = [NSString stringWithFormat:@"%@Action:", [json objectForKey:@"method"]];
        NSDictionary *data   = [json objectForKey:@"data"];
        
        SEL selector = NSSelectorFromString(method);
        
        if ([self respondsToSelector:selector]) {
            
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            NSString *response = [self performSelector:selector withObject:data];
            action = [NSString stringWithFormat:@"nguiwv.response(%@, '%@');", identifier, response];
            
        } else {
            
            action = [NSString stringWithFormat:@"nguiwv.error(%@);", identifier];
        }
        
        [wv stringByEvaluatingJavaScriptFromString:action];
        
        return NO;
    }
    
    return YES;
}

@end
