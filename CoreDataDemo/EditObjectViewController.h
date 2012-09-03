//
//  EditObjectViewController.h
//  CoreDataDemo
//
//  Created by lu jingyu on 9/3/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditObjectViewController : UIViewController {
    
    IBOutlet UITextField *_tfMemberId;
    IBOutlet UITextField *_tfMemberName;
}
@property (nonatomic, retain) NSManagedObject *memberObject;

@end
