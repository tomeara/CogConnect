//
//  Result.h
//  CogConnect
//
//  Created by German Bejarano on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Test;
@class TestLevel;

@interface Result :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * average;
@property (nonatomic, retain) NSDate * end;
@property (nonatomic, retain) NSNumber * numerOfTries;
@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) TestLevel * testLevel;
@property (nonatomic, retain) Test * test;

@end



