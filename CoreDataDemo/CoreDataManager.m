//
//  CoreDataManager.m
//  CoreDataDemo
//
//  Created by lu jingyu on 9/3/12.
//  Copyright (c) 2012 jingyu lu. All rights reserved.
//

#import "CoreDataManager.h"

static CoreDataManager *instance = nil;

@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (CoreDataManager *)sharedInstance {
    @synchronized(self) {
        if (instance == nil) {
            instance = [[CoreDataManager alloc] init];
        }
    }
    return instance;
}

- (void)dealloc
{
	[_managedObjectContext release];
	[_managedObjectModel release];
	[_persistentStoreCoordinator release];
    [super dealloc];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataDemo.sqlite"];
    
    // 设置预置数据库(如果需要的话)
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *storePath = [storeURL path];
    if ([fileManager fileExistsAtPath:storePath]) {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"CoreData" ofType:@"sqlite"];
        if (defaultStorePath) {
            [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
        }
    }
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data Behavior

- (NSManagedObject *)generateManagedObjectByEntityName:(NSString *)entityName {
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
	NSManagedObject *managedObject = [[[NSClassFromString(entityName) alloc] initWithEntity:entity insertIntoManagedObjectContext:nil] autorelease];
	return managedObject;
}

- (void)insertManagedObject:(NSManagedObject *)object {
	
    // 创建查询
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 设置实体
	[fetchRequest setEntity:object.entity];
    
    // 设置查询条件
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"memberId = %@", [object valueForKey:@"memberId"]]];
    
    // 执行查询
	NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
	[fetchRequest release];
    
    // 判断结果是否已存在，如果不存在则进行插入操作
	if (result == nil || [result count] == 0) {
		[self.managedObjectContext insertObject:object];
		[self saveContext];
	}
}

- (void)deleteManagedObject:(NSManagedObject *)object {
    [self.managedObjectContext deleteObject:object];
    [self saveContext];
}	

- (NSArray *)fetchObjectsForEntityName:(NSString *)entityName
							 predicate:(NSPredicate *)predicate
					   sortDescriptors:(NSArray *)sortDescriptors {
	
	// 首先创建一个NSFetchRequest的实例
	// 一般的，执行一次查询需要设置：实体(查哪张表)，查询条件，查询结果的排序规则等等
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	// 设置实体
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
											  inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// 设置查询条件
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
	
	// 设置查询结果的排序规则
    if (sortDescriptors) {
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
	
	// 执行查询
	NSError *error = nil;
	NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	[fetchRequest release];
	if (error) {
		NSLog(@"%@", [error description]);
		return nil;
	}
	return result;
}

@end
