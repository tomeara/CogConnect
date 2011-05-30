//
//  TestLevel.h
//  CogConnect
//
//  Created by German Bejarano on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Result;

@interface TestLevel :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * timeSpan;
@property (nonatomic, retain) NSNumber * levelNumber;
@property (nonatomic, retain) NSNumber * moveRate;
@property (nonatomic, retain) NSNumber * buttonScale;
@property (nonatomic, retain) NSNumber * rotateRate;
@property (nonatomic, retain) Result * results;

@end



