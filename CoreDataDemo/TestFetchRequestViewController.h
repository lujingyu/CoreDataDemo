//
//  TestFetchRequestViewController.h
//  CoreDataDemo
//
//  Created by jingyu lu on 9/2/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestFetchRequestViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}
- (IBAction)actionAdd:(id)sender;
- (IBAction)actionRefresh:(id)sender;

@end
