ngUIWebView
===========

An AngularJS service to send messages from javascript to Objective-C

Install
-------

```
bower install ng-uiwebview
```

Usage
-----

Add the ```ngUIWebView.min.js``` to your javascripts after the AngularJS file

```html
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.22/angular.min.js"></script>
<script src="ngUIWebView.min.js"></script>
```

Copy the ```ngUIWebView``` folder into your project and extend the ngUIWebView class

**MyViewController.h**

```Objective-C
#import <UIKit/UIKit.h>
#import "ngUIWebView.h"

@interface MyViewController:ngUIWebView
{
    IBOutlet UIWebView *webView;
}
```

Delegate your UIWebView instance and add some actions

**MyViewController.m**

```Objective-C
@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webView.delegate = self;
}

- (void)saveAction:(NSData *)data
{
    [[NSUserDefaults standardUserDefaults] setObject:(NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data] forKey:@"storage"];
}

- (NSData*)loadAction:(NSData *)data
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
```

Add the module to your AngularJS app and use it!

```javascript
angular
    .module('app', ['ngUIWebView'])
    .controller('MyController', function (UIWebView) {

        var self = this;
        self.data = {};

        var error = function (error) {

            alert(error.message);
        };

        self.save = function (form) {

            UIWebView
                .send('save', self.data)
                .then(function () {

                    form.$setPristine();
                })
                .catch(error);
        };

        self.load = function () {

            UIWebView
                .send('load')
                .then(function (data) {

                    angular.extend(self.data, data);
                })
                .catch(error);
        };

        self.notify = function () {

            UIWebView
                .send('notify')
                .catch(error);
        };
    });
```
