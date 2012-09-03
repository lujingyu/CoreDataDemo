//
//  TestFetchedResultsViewController.h
//  CoreDataDemo
//
//  Created by jingyu lu on 9/2/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestFetchedResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate> {
	
	NSFetchedResultsController *fetchedResultsController;
    UITableView *_tableView;
}
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (IBAction)actionAdd:(id)sender;

@end
