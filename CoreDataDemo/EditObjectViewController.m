//
//  EditObjectViewController.m
//  CoreDataDemo
//
//  Created by lu jingyu on 9/3/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import "EditObjectViewController.h"
#import "CoreDataManager.h"

@interface EditObjectViewController ()

@end

@implementation EditObjectViewController
@synthesize memberObject;

- (void)dealloc {
    self.memberObject = nil;
    [super dealloc];
}

- (void)actionDone:(id)sender {
	if (_tfMemberId.text.length > 0 && _tfMemberName.text.length > 0) {
        
		[self.memberObject setValue:_tfMemberId.text forKey:@"memberId"];
		[self.memberObject setValue:_tfMemberName.text forKey:@"memberName"];
        [self.memberObject.managedObjectContext save:NULL];
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

    _tfMemberId.text = [self.memberObject valueForKey:@"memberId"];
    _tfMemberName.text = [self.memberObject valueForKey:@"memberName"];
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
