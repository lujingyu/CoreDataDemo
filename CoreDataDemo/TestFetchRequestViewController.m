//
//  TestFetchRequestViewController.m
//  CoreDataDemo
//
//  Created by jingyu lu on 9/2/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import "TestFetchRequestViewController.h"
#import "InsertObjectViewController.h"
#import "EditObjectViewController.h"
#import "CoreDataManager.h"

@interface TestFetchRequestViewController ()

@end

@implementation TestFetchRequestViewController

- (void)dealloc {
    [_dataSource release];
    [_tableView release];
    [super dealloc];
}

- (NSArray *)fetchObjects {
    return [[CoreDataManager sharedInstance] fetchObjectsForEntityName:@"Member"
                                                             predicate:nil
                                                       sortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"memberId" ascending:YES]]];
}

- (IBAction)actionAdd:(id)sender {
    InsertObjectViewController *controller = [[InsertObjectViewController alloc] init];
	UINavigationController *nvController = [[UINavigationController alloc] initWithRootViewController:controller];
	[controller release];
	[self presentModalViewController:nvController animated:YES];
	[nvController release];
}

- (IBAction)actionRefresh:(id)sender {
    [_dataSource removeAllObjects];
    [_dataSource addObjectsFromArray:[self fetchObjects]];
    [_tableView reloadData];
}

- (void)actionEdit:(NSManagedObject *)object {
    EditObjectViewController *controller = [[EditObjectViewController alloc] init];
    controller.memberObject = object;
    UINavigationController *nvController = [[UINavigationController alloc] initWithRootViewController:controller];
    [controller release];
    [self presentModalViewController:nvController animated:YES];
    [nvController release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	self.navigationItem.title = @"FetchRequest";
    
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    [_dataSource addObjectsFromArray:[self fetchObjects]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 372) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *obj = [_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [obj valueForKey:@"memberName"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSManagedObject *obj = [_dataSource objectAtIndex:indexPath.row];
    [self actionEdit:obj];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object.
        NSManagedObject *obj = [_dataSource objectAtIndex:indexPath.row];
        // 从CoreData中删除
        [[CoreDataManager sharedInstance] deleteManagedObject:obj];
        // 从内存中删除
        [_dataSource removeObjectAtIndex:indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
}

@end











