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

- (NSString*)saveAction:(NSDictionary *)data
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"mystorage"];
    
    return @"";
}

- (NSString*)loadAction:(NSDictionary *)data
{
    NSError *error;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *json = [NSJSONSerialization
                    dataWithJSONObject:[defaults objectForKey:@"mystorage"]
                    options:0
                    error:&error];
    
    return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}
```

Add the module to your AngularJS app

```javascript
angular.module('app', ['ngUIWebView']);
```

And use it!

```javascript
angular
	.module('app')
	.controller('MyController', ['UIWebView', function (UIWebView) {

	    UIWebView
			.send('save', {
				foo: [1, 2, 3]
			})
			.then(function () {

				console.log('saved!');
			})
			.catch(function (error) {

				console.log(error);
			});

	    UIWebView
	        .send('load')
	        .then(function (data) {

	            console.log(data);
	        })
	        .catch(function (error) {

	            console.log(error);
	        });
	}]);
```
