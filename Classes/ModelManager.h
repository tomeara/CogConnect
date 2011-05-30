//
//  ModelManager.h
//  Managers
//
//  Created by German Bejarano on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User.h"
#import "Test.h"
#import "TestLevel.h"
#import "Result.h"

#define kRecentResultListIndex 0
#define kRecentResultListLength 20
#define kNumberOfResultsToKeepInCoreData 500


@interface ModelManager : NSObject {
	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;       
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (ModelManager *) sharedInstance;
- (NSString *)applicationDocumentsDirectory;
- (BOOL) doSave;

#pragma mark Users
- (User*) addUser;
- (BOOL) deleteUser:(User*)user;
- (User*) getUserWithId:(NSNumber*)userId;
- (User*) getUserWithFirstName:(NSString*)firstName lastName:(NSString*) lastName;
#pragma mark -

#pragma mark Test
- (Test*) addTest;
- (BOOL) deleteTest:(Test*)test;
- (Test*) getTestWithId:(NSNumber*)testId;
#pragma mark -

#pragma mark Results
- (Result*) addResult;
- (BOOL) deleteResult:(Result*)result;
#pragma mark -

#pragma mark TestLevel
- (TestLevel*) addTestLevel;
- (BOOL) deleteTestLevel:(TestLevel*)testLEvel;
- (TestLevel*) getTestLevelWithLevel:(NSNumber*)levelNumber;
#pragma mark -

@end
