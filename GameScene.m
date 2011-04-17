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
		
		//Set game time and move time
		_timer = 5;
		_buttonScale = 3;
		
		//Set the sprite
		_button = [CCSprite spriteWithFile:@"button.png"];
		_button.scale = _buttonScale;
		[self addChild:_button z:0 tag:1];
		
		_screenSize = [[CCDirector sharedDirector] winSize];
		_buttonHeight = [_button texture].pixelsHigh*_buttonScale;
		_button.position = CGPointMake(_screenSize.width / 2, _screenSize.height /2);
		self.isTouchEnabled = YES;
	}
	return self;
}

-(void) registerWithTouchDispatcher{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint startTouch = [touch locationInView: touch.view];
	startTouch = [[CCDirector sharedDirector] convertToGL: startTouch];
	startTouch = [self convertToNodeSpace:startTouch];
	
	CGFloat touchDistance = ccpDistance(_button.position, startTouch);
	if(touchDistance < _buttonHeight*.5){
		//CCMoveTo *move = [CCMoveTo actionWithDuration:_timer position:CGPointMake(_screenSize.width - _buttonHeight, _screenSize.height - _buttonHeight)];
		//Bezier Curve Simulation
		
		//You can choose the two control point location as well as the endposition location as the way you wish.
		ccBezierConfig bezier;
		int i;
		int bezierTotalPoints = 3;
		
		for (i=0; i < bezierTotalPoints; i++) {
			CGFloat randomY = (CGFloat) random()/(CGFloat) RAND_MAX * (_screenSize.width/2);
			CGFloat randomX = (CGFloat) random()/(CGFloat) RAND_MAX * (_screenSize.width/2);
			bezier.controlPoint_1 = ccp(randomX, randomY);
		}
		CGFloat randomEndX = (CGFloat) random()/(CGFloat) RAND_MAX * (_screenSize.width/2);
		CGFloat randomEndY = (CGFloat) random()/(CGFloat) RAND_MAX * (_screenSize.width/2);
		
		bezier.endPosition = ccp(randomEndX, randomEndY);
		id bezierForward = [CCBezierBy actionWithDuration:bezierTotalPoints bezier:bezier];
		id bezierBack = [bezierForward reverse];
		//CCEaseBounceOut *bounce=[CCEaseBounceIn actionWithAction:bezierForward];
		id seq = [CCSequence actions: bezierForward, bezierBack, nil];
		
		id rep = [CCRepeatForever actionWithAction:seq];
		
		//[target runAction:rep];
		[_button runAction:rep];
		CCLOG(@"Touch Began");
	}
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint endTouch = [touch locationInView: [touch view]];		
	endTouch = [[CCDirector sharedDirector] convertToGL: endTouch];
	endTouch = [self convertToNodeSpace:endTouch];
	CCLOG(@"Touch Ended");
	
	CGFloat touchDistance = ccpDistance(_button.position, endTouch);
	if(touchDistance < _buttonHeight*.5){
		CCLOG(@"Success");
	}else{
		CCLOG(@"Fail");
		_button.position = CGPointMake(_screenSize.width / 2, _screenSize.height /2);
	}
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint touchLocation = [touch locationInView: [touch view]];		
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	touchLocation = [self convertToNodeSpace:touchLocation];
	CGFloat touchDistance = ccpDistance(_button.position, touchLocation);
	//CCLOG(@"Button: %@ | Touch: %@", NSStringFromCGPoint(_button.position), NSStringFromCGPoint(touchLocation));
	if(touchDistance < _buttonHeight*.5){
		_button.color = ccRED;
	}else {
		_button.color = ccBLUE;
	}

}

-(CGPoint) getRandomPointOnScreen{
	
	CGFloat randomX = arc4random() % (int) _screenSize.width;
	CGFloat randomY = arc4random() % (int) _screenSize.height;
	CGPoint randomPoint = ccp(abs(randomX), abs(randomY));
	CCLOG(@"x: %f, y: %f", randomX, randomY);
	return randomPoint;
}

-(void) dealloc{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	[super dealloc];
}

@end
