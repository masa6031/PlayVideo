//
//  ViewController.m
//  PlayVideo
//
//  Created by masa on 2014/07/11.
//  Copyright (c) 2014年 Mina Kobayashi. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "HTMLParser.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableData *receivedData;
    NSArray *aNodes;
    NSMutableArray *urlArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    urlArray = [NSMutableArray array];
    
    NSURL *url = [NSURL URLWithString:@"http://www.anitube.se/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(!connection)
    {
        NSLog(@"Connection error");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response { receivedData = [[NSMutableData alloc] init];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *html = [[NSString alloc] initWithBytes:receivedData.bytes length:receivedData.length encoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    HTMLNode *bodyNode = [parser body];
    aNodes = [bodyNode findChildTags:@"a"];
    for (HTMLNode *node in aNodes) {
        NSRange range = [[node getAttributeNamed:@"href"] rangeOfString:@"http://www.anitube.se/video/"];
        
        if(range.location != NSNotFound)
        {
//            NSLog(@"%@",[node getAttributeNamed:@"href"]);
            [urlArray addObject:[node getAttributeNamed:@"href"]];
            [self.tableView reloadData];
        } else {
        }
        
    }
}
//セクション毎の行数を指定する
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [urlArray count];
}
//セルの内容を返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //IB上のCellのidentifireと一致させる
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if([urlArray count] != 0)
        cell.textLabel.text = [urlArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    
    //cellを返す
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"Segue"]){
        //クリックした所のセクションと行の情報が格納される
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        //遷移先のsegueの情報を取得して、*viewControllerに入れる
        SecondViewController *ViewControlloer = [segue destinationViewController];
        
        //viewControllerの中にあるcityNameに値を渡す
        ViewControlloer.urlString = [urlArray objectAtIndex:indexPath.row];
        
    }
}

@end
