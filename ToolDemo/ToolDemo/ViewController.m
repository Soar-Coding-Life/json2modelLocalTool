//
//  ViewController.m
//  ToolDemo
//
//  Created by mac on 2020/1/1.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController()

@property (strong, nonatomic) WKWebView *webView;
@property (nonatomic, strong) NSScrollView *scrollView;

@end

@implementation ViewController

- (WKWebView *)webView {
    if (!_webView) {
        //以下代码适配屏幕大小
        NSString *jScript = @"var meta = document.createElement(‘meta‘); meta.setAttribute(‘name‘, ‘viewport‘); meta.setAttribute(‘content‘, ‘width=device-width‘); document.getElementsByTagName(‘head‘)[0].appendChild(meta); var imgs = document.getElementsByTagName(‘img‘);for (var i in imgs){imgs[i].style.maxWidth=‘100%‘;imgs[i].style.height=‘auto‘;}";
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        _webView = [[WKWebView alloc] initWithFrame:(NSRect){{0,100},{1000,1000}} configuration:wkWebConfig];
        [self.scrollView addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *webURLString = @"http://192.168.1.166/json2model/index.html";
//    NSURL *url = [NSURL URLWithString:webURLString];
//    NSURLRequest  * requet = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest: requet];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"json2model"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:req];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[NSScrollView alloc] initWithFrame:(NSRect){{0,0},NSScreen.mainScreen.frame.size}];
        [self.view addSubview: _scrollView];
    }
    return _scrollView;
}

@end
