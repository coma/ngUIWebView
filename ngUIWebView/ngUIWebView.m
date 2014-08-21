#import "ngUIWebView.h"

@interface ngUIWebView ()

@end

@implementation ngUIWebView
- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *url = [[request URL] absoluteString];
    
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
        
        NSString     *method = [NSString stringWithFormat:@"%@Action:", json[@"method"]];
        
        SEL selector = NSSelectorFromString(method);
        
        if ([self respondsToSelector:selector]) {
            
            @try {
                
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:json[@"data"]];
                id response  = [self performSelector:selector withObject:data];
                
                if (response == nil) {
                    
                    action = [NSString stringWithFormat:@"nguiwv.response(%@);", identifier];
                    
                } else {
                    
                    action = [NSString stringWithFormat:@"nguiwv.response(%@, '%@');", identifier, [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]];
                }
                
            } @catch (NSException * e) {
                
                action = [NSString stringWithFormat:@"nguiwv.error(%@, '%@');", identifier, [e reason]];
            }
            
        } else {
            
            action = [NSString stringWithFormat:@"nguiwv.error(%@, 'Method not found.');", identifier];
        }
        
        [wv stringByEvaluatingJavaScriptFromString:action];
        
        return NO;
    }
    
    return YES;
}

@end
