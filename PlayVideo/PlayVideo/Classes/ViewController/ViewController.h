//
//  ViewController.h
//  PlayVideo
//
//  Created by masa on 2014/07/11.
//  Copyright (c) 2014年 Mina Kobayashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
