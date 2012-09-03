//
//  Group.h
//  CoreDataDemo
//
//  Created by lu jingyu on 9/3/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Group : NSManagedObject

@property (nonatomic, retain) NSString * groupId;
@property (nonatomic, retain) NSString * groupName;
@property (nonatomic, retain) NSSet *members;
@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addMembersObject:(NSManagedObject *)value;
- (void)removeMembersObject:(NSManagedObject *)value;
- (void)addMembers:(NSSet *)values;
- (void)removeMembers:(NSSet *)values;

@end
