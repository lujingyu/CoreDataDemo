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
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择在哪个线程上做操作"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"主线程", @"子线程", nil];
        [sheet showInView:self.view];
        [sheet release];
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

- (void)insertMemberObject:(NSDictionary *)para {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:[CoreDataManager sharedInstance].persistentStoreCoordinator];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Member" inManagedObjectContext:context];
    NSManagedObject *obj = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    [obj setValue:[para valueForKey:@"memberId"] forKey:@"memberId"];
    [obj setValue:[para valueForKey:@"memberName"] forKey:@"memberName"];
    [context save:NULL];
    [obj release];
    [context release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            // 主线程
            NSManagedObject *obj = [[CoreDataManager sharedInstance] generateManagedObjectByEntityName:@"Member"];
            [obj setValue:_tfMemberId.text forKey:@"memberId"];
            [obj setValue:_tfMemberName.text forKey:@"memberName"];
            [[CoreDataManager sharedInstance] insertManagedObject:obj];
            [self dismissModalViewControllerAnimated:YES];
            [self dismissModalViewControllerAnimated:YES];
        }
            break;
        case 1: {
            // 子线程
            NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:
                                  _tfMemberId.text, @"memberId",
                                  _tfMemberName.text, @"memberName",
                                  nil];
            [NSThread detachNewThreadSelector:@selector(insertMemberObject:) toTarget:self withObject:para];
            [self dismissModalViewControllerAnimated:YES];
        }
            break;
        case 2: {
            // 取消
        }
            break;
        default:
            break;
    }
}

@end
