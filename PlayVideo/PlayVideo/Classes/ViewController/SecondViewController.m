//
//  SecondViewController.m
//  PlayVideo
//
//  Created by masa on 2014/07/11.
//  Copyright (c) 2014年 Mina Kobayashi. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
{
    NSMutableData *receivedData;
    NSArray *aNodes;
    NSMutableArray *urlArray;
    NSURLRequest *request;
    int count;
    NSString *cutUrlString;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = (id)self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.hidden = YES;
    count = 0;
    
    urlArray = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:self.urlString];
    request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)webViewDidStartLoad:(UIWebView*)webView
{
    count++;
    NSLog(@"ここ：%d",count);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    count--;
    NSLog(@"ああ：%d",count);
    if(count <= 0)
    {
    self.webView.scrollView.contentOffset = CGPointMake(220, 300);
    self.webView.hidden = NO;
        
    }
    
}


@end
