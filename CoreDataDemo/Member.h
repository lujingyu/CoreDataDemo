//
//  Member.h
//  CoreDataDemo
//
//  Created by lu jingyu on 9/3/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Group;

@interface Member : NSManagedObject

@property (nonatomic, retain) NSString * memberId;
@property (nonatomic, retain) NSString * memberName;
@property (nonatomic, retain) Group *group;

@end
