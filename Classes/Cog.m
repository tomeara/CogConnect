//
//  Cog.m
//  CogConnect
//
//  Created by Edward O'Meara on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Cog.h"


@implementation Cog

-(id)initCog{
	if((self == [super init])){
		[CCSprite spriteWithFile:@"button.png"];
	}
	return self;
}

@end
