//
//  GameScene.m
//  CogConnect
//
//  Created by Edward O'Meara on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

+(id) scene{
	CCScene *scene = [CCScene node];
	CCLayer	*layer = [GameScene node];
	[scene addChild:layer];
	return scene;
}

-(id) init{
	if((self == [super init])){
		CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
		
		button = [CCSprite spriteWithFile:@"button.png"];
		[self addChild:button z:0 tag:1];
		
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		float imageHeight = [button texture].contentSize.height;
		button.position = CGPointMake(screenSize.width / 2, screenSize.height /2);
		CCMoveTo *move = [CCMoveTo actionWithDuration:5 position:CGPointMake(screenSize.width - imageHeight, screenSize.height - imageHeight)];
		[button runAction:move];
		self.isTouchEnabled = YES;
	}
	return self;
}

-(void) registerWithTouchDispatcher{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	CCLOG(@"Touch Began");
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint touchLocation = [touch locationInView: [touch view]];		
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	touchLocation = [self convertToNodeSpace:touchLocation];
	CCLOG(@"Touch Ended");
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint touchLocation = [touch locationInView: [touch view]];		
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	touchLocation = [self convertToNodeSpace:touchLocation];
	CCLOG(@"Touch Moving");
}

-(void) dealloc{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	[super dealloc];
}

@end
