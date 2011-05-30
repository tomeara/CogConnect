//
//  User.h
//  CogConnect
//
//  Created by German Bejarano on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Test;

@interface User :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) Test * test;

@end



