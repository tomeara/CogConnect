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
		
		_button = [CCSprite spriteWithFile:@"button.png"];
		[self addChild:_button z:0 tag:1];
		
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		_buttonHeight = [_button texture].contentSize.height;
		_button.position = CGPointMake(screenSize.width / 2, screenSize.height /2);
		CCMoveTo *move = [CCMoveTo actionWithDuration:5 position:CGPointMake(screenSize.width - _buttonHeight, screenSize.height - _buttonHeight)];
		[_button runAction:move];
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
	CCLOG(@"Button: %@ | Touch: %@", NSStringFromCGPoint(_button.position), NSStringFromCGPoint(touchLocation));
	//CGPoint moveDifference = ccpSub(touchLocation, _button.position);
	if(
	   (touchLocation.y < _button.position.y+(_buttonHeight*.5))&&
	   (touchLocation.x < _button.position.x+(_buttonHeight*.5))&&
	   (touchLocation.y > _button.position.y-(_buttonHeight*.5))&&
	   (touchLocation.x > _button.position.x-(_buttonHeight*.5))
	){
		CCLOG(@"You are inside.");
		_button.color = ccRED;
	}else {
		_button.color = ccBLUE;
	}

}

-(void) dealloc{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	[super dealloc];
}

@end
