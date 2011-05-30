//
//  ModelManager.m
//  Managers
//
//  Created by German Bejarano on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModelManager.h"

@implementation ModelManager

+ (ModelManager *) sharedInstance {
	static ModelManager *sharedInstance;
	
	@synchronized(self) {
		if(!sharedInstance)
			sharedInstance = [[ModelManager alloc] init];
		
		return sharedInstance;
	}
	return nil;
}
- (void) initVersion1 {
	
	//[self doSave];
}
- (id) init  {
	if ((self = [super init])) {
		NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
		int lastInitializedVersion = [defaults integerForKey:@"lastInitializedVersion"];
		
		//If we don't break in each case, we get the cascade effect we need to migrate data
		//or initialize any Entity
		switch (lastInitializedVersion) {
			case 0:
				[self initVersion1];
				lastInitializedVersion = 1;
		}
		
		[defaults setInteger:lastInitializedVersion forKey:@"lastInitializedVersion"];
		[defaults synchronize];
	}
	return self;
}
- (void) handleErrorOcurred:(NSError*)error {
	// TODO: Update to handle the error appropriately.
	NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
	NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
	if(detailedErrors != nil && [detailedErrors count] > 0) {
		for(NSError* detailedError in detailedErrors) {
			NSLog(@"  DetailedError: %@", [detailedError userInfo]);
		}
	}
	else {
		NSLog(@"  %@", [error userInfo]);
	}
}
- (BOOL) doSave {
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			[self handleErrorOcurred:error];
            return NO;
        } 
    }
	return YES;
}
- (NSFetchRequest*) getRequestForEntity:(NSString*)entityName {
	if (self.managedObjectContext) {
		NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
		NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
		[request setEntity:entity];
		return request;
	} else {
		return nil;
	}
}
- (void) setSortDescriptorForRequest:(NSFetchRequest*)request withKey:(NSString*)keyName ascending:(BOOL)ascending {
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:keyName ascending:ascending];
	
	NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObjects:nil];
	if ([request sortDescriptors]) { //Append to existing ones
		[sortDescriptors addObjectsFromArray:[request sortDescriptors]];
	}
	[sortDescriptors addObject:sortDescriptor];
	[sortDescriptor release];
	[request setSortDescriptors:[NSArray arrayWithArray:sortDescriptors]];
}
- (BOOL) deleteManagedObjectWithID:(NSString*)objStringID {
	if (self.managedObjectContext) {
		NSError *error;
		NSURL* objURLID = [NSURL URLWithString:objStringID];
		NSManagedObjectID* objID = [persistentStoreCoordinator managedObjectIDForURIRepresentation:objURLID];
		NSManagedObject* obj = [managedObjectContext existingObjectWithID:objID error:&error];
		[managedObjectContext deleteObject:obj];
		return [self doSave];
	} else {
		return NO;
	}
}

#pragma mark Users
- (User*) addUser {
	if (self.managedObjectContext) {
		User *result = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
		if ([self doSave]) {
			return result;
		} else {
			return nil;
		}
	} else {
		return nil;
	}
}

- (BOOL) deleteUser:(User*)user{
	[managedObjectContext deleteObject:user];
	return [self doSave];
}

- (User*) getUserWithId:(NSNumber*)userId{
	NSFetchRequest *request = [self getRequestForEntity:@"User"];
	if (request) {
		NSError *err;
		NSPredicate* predicate = [NSPredicate predicateWithFormat:@"userId == %@", userId];
		[request setPredicate:predicate];
		NSArray* results = [managedObjectContext executeFetchRequest:request error:&err];
		if ([results count] >= 1) {
			return (User*)[results objectAtIndex:0];
		}
	}
	return nil;
}

- (User*) getUserWithFirstName:(NSString*)firstName lastName:(NSString*) lastName{
	NSFetchRequest *request = [self getRequestForEntity:@"User"];
	if (request) {
		NSError *err;
		NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(firstName == %@) && (lastName == %@)", firstName, lastName];
		[request setPredicate:predicate];
		NSArray* results = [managedObjectContext executeFetchRequest:request error:&err];
		if ([results count] >= 1) {
			return (User*)[results objectAtIndex:0];
		}
	}
	return nil;
}
#pragma mark -

#pragma mark Test
- (Test*) addTest {
	if (self.managedObjectContext) {
		Test *result = (Test *)[NSEntityDescription insertNewObjectForEntityForName:@"Test" inManagedObjectContext:managedObjectContext];
		if ([self doSave]) {
			return result;
		} else {
			return nil;
		}
	} else {
		return nil;
	}
}

- (BOOL) deleteTest:(Test*)test{
	[managedObjectContext deleteObject:test];
	return [self doSave];
}

- (Test*) getTestWithId:(NSNumber*)testId{
	NSFetchRequest *request = [self getRequestForEntity:@"Test"];
	if (request) {
		NSError *err;
		NSPredicate* predicate = [NSPredicate predicateWithFormat:@"testId == %@", testId];
		[request setPredicate:predicate];
		NSArray* results = [managedObjectContext executeFetchRequest:request error:&err];
		if ([results count] >= 1) {
			return (Test*)[results objectAtIndex:0];
		}
	}
	return nil;
}
#pragma mark -

#pragma mark Results
- (Result*) addResult {
	if (self.managedObjectContext) {
		Result *result = (Result *)[NSEntityDescription insertNewObjectForEntityForName:@"Result" inManagedObjectContext:managedObjectContext];
		if ([self doSave]) {
			return result;
		} else {
			return nil;
		}
	} else {
		return nil;
	}
}

- (BOOL) deleteResult:(Result*)result{
	[managedObjectContext deleteObject:result];
	return [self doSave];
}
#pragma mark -


#pragma mark TestLevel
- (TestLevel*) addTestLevel {
	if (self.managedObjectContext) {
		TestLevel *result = (TestLevel *)[NSEntityDescription insertNewObjectForEntityForName:@"TestLevel" inManagedObjectContext:managedObjectContext];
		if ([self doSave]) {
			return result;
		} else {
			return nil;
		}
	} else {
		return nil;
	}
}

- (BOOL) deleteTestLevel:(TestLevel*)testLEvel{
	[managedObjectContext deleteObject:testLEvel];
	return [self doSave];
}

- (TestLevel*) getTestLevelWithLevel:(NSNumber*)levelNumber{
	NSFetchRequest *request = [self getRequestForEntity:@"TestLevel"];
	if (request) {
		NSError *err;
		NSPredicate* predicate = [NSPredicate predicateWithFormat:@"levelNumber == %@", levelNumber];
		[request setPredicate:predicate];
		NSArray* results = [managedObjectContext executeFetchRequest:request error:&err];
		if ([results count] >= 1) {
			return (TestLevel*)[results objectAtIndex:0];
		}
	}
	return nil;
}
#pragma mark -

#pragma mark Core Data stack
/* Returns the managed object context for the application. If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application. */
- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}
/* Returns the managed object model for the application. If the model doesn't already exist, it is created by merging all of the models found in the application bundle. */
- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}
/* Returns the persistent store coordinator for the application. If the coordinator doesn't already exist, it is created and the application's store added to it. */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"cogconnect.sqlite"];
    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];    
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
	
    NSError *error;
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
		[self handleErrorOcurred:error];
		[persistentStoreCoordinator release];
		persistentStoreCoordinator = nil;
    }
    return persistentStoreCoordinator;
}
#pragma mark -
#pragma mark Application's documents directory
/* Returns the path to the application's documents directory. */
- (NSString *)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}
#pragma mark -
- (void) dealloc {
	[managedObjectContext release];
	managedObjectContext = nil;
    [managedObjectModel release];
	managedObjectModel = nil;
    [persistentStoreCoordinator release];
	persistentStoreCoordinator = nil;
	[super dealloc];
}
@end
