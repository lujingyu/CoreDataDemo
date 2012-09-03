//
//  CoreDataManager.h
//  CoreDataDemo
//
//  Created by lu jingyu on 9/3/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataManager *)sharedInstance;

- (void)saveContext;

- (NSManagedObject *)generateManagedObjectByEntityName:(NSString *)entityName;

// 增
- (void)insertManagedObject:(NSManagedObject *)object;

// 删
- (void)deleteManagedObject:(NSManagedObject *)object;

// 查
- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName
							 predicate:(NSPredicate *)predicate
					   sortDescriptors:(NSArray *)sortDescriptors;

@end
