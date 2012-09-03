//
//  RootViewController.m
//  CoreDataDemo
//
//  Created by jingyu lu on 9/2/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import "RootViewController.h"
#import "TestFetchedResultsViewController.h"
#import "TestFetchRequestViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    // Do any additional setup after loading the view from its nib.
	
	self.navigationItem.title = @"Core Data";
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	tableView.dataSource = self;
	tableView.delegate = self;
	[self.view addSubview:tableView];
	[tableView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *identifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	if (indexPath.row == 0) {
		cell.textLabel.text = @"NSFetchRequest";
	}
	else {
		cell.textLabel.text = @"NSFetchedResultsController";
	}
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 0) {
		TestFetchRequestViewController *controller = [[TestFetchRequestViewController alloc] init];
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];
	}
	else {
		TestFetchedResultsViewController *controller = [[TestFetchedResultsViewController alloc] init];
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];
	}
}

@end
