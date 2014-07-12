//
//  SecondViewController.h
//  PlayVideo
//
//  Created by masa on 2014/07/11.
//  Copyright (c) 2014年 Mina Kobayashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<NSURLConnectionDataDelegate>

@property (nonatomic,strong) NSString *urlString;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
