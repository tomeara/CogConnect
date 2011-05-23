//
//  StartScreen.m
//  CogConnect
//
//  Created by Edward O'Meara on 5/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StartScene.h"


@implementation StartScene

+(id) scene{
	CCScene *scene = [CCScene node];
	CCLayer	*layer = [StartScene node];
	[scene addChild:layer];
	return scene;
}

-(id) init{
	if((self == [super init])){
		//[[CCDirector sharedDirector] pushScene: GameScene];
	}
	return self;
}

-(void) dealloc{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	[super dealloc];
}

@end
