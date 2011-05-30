//
//  NSManagedObject+Extras.m
//  Managers
//
//  Created by German Bejarano on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.

#import "NSManagedObject+Extras.h"


@implementation NSManagedObject(Extras)

- (NSString*) objectStringID {
	return [[[self objectID] URIRepresentation] absoluteString];
}

@end
