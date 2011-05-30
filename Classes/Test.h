//
//  Test.h
//  CogConnect
//
//  Created by German Bejarano on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Result;
@class User;

@interface Test :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * testId;
@property (nonatomic, retain) NSSet* results;
@property (nonatomic, retain) User * user;

@end


@interface Test (CoreDataGeneratedAccessors)
- (void)addResultsObject:(Result *)value;
- (void)removeResultsObject:(Result *)value;
- (void)addResults:(NSSet *)value;
- (void)removeResults:(NSSet *)value;

@end

