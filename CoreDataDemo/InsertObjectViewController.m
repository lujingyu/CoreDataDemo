//
//  InsertObjectViewController.m
//  CoreDataDemo
//
//  Created by jingyu lu on 9/2/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import "InsertObjectViewController.h"
#import "CoreDataManager.h"

@interface InsertObjectViewController ()

@end

@implementation InsertObjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)actionDone:(id)sender {
	if (_tfMemberId.text.length > 0 && _tfMemberName.text.length > 0) {
		NSManagedObject *obj = [[CoreDataManager sharedInstance] generateManagedObjectByEntityName:@"Member"];
		[obj setValue:_tfMemberId.text forKey:@"memberId"];
		[obj setValue:_tfMemberName.text forKey:@"memberName"];
		[[CoreDataManager sharedInstance] insertManagedObject:obj];
        [self dismissModalViewControllerAnimated:YES];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
														message:@"资料填写不完整"
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (void)actionCancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
																	style:UIBarButtonItemStylePlain
																   target:self
																   action:@selector(actionCancel:)];
	self.navigationItem.leftBarButtonItem = leftButton;
	[leftButton release];

	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
																	style:UIBarButtonItemStylePlain
																   target:self
																   action:@selector(actionDone:)];
	self.navigationItem.rightBarButtonItem = rightButton;
	[rightButton release];
	
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

@end
