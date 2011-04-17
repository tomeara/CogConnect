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
		CCLOG(@"height: %f, width: %f", _screenSize.height, _screenSize.width);
		CCLOG(@"button height: %f", _buttonHeight);
		
		_timeLabel = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:24];
		_timeLabel.position = CGPointMake(_screenSize.width / 2, _screenSize.height - 24);
		[self addChild:_timeLabel];
		
		// schedule a callback
        [self scheduleUpdate];  
        [self schedule: @selector(tick2:) interval:1];
		
		
		self.isTouchEnabled = YES;
	}
	return self;
}

-(void) update: (ccTime) dt
{	
	
}

-(void) tick2: (ccTime) dt
{
	if (_started == YES){
		_timer --;
		if (_timer > 0) {
			[_timeLabel setString:[NSString stringWithFormat:@"Time left: %d", _timer]];
		}else{
			[_timeLabel setString:[NSString stringWithString:@"Time's Up!"]];
		}
	}
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
		//cpShape *square = [smgr addPolyAt:cpv(240,160) mass:100 rotation:0 numPoints:4 points:cpv(0, -10), cpv(10, 0), cpv(0, 10), cpv(-10, 0)];
		//int bezierTotalPoints = 3;
		
		id ballMove1 = [CCMoveTo actionWithDuration:3 position:[self getRandomPointOnScreen]];
		id ballMove2 = [CCMoveTo actionWithDuration:3 position:[self getRandomPointOnScreen]];
		id ballMove3 = [CCMoveTo actionWithDuration:3 position:[self getRandomPointOnScreen]];
		id ballMove4 = [CCMoveTo actionWithDuration:3 position:_button.position];
		
		id seq = [CCSequence actions: ballMove1, ballMove2, ballMove3, ballMove4, nil];
		
		_rep = [CCRepeatForever actionWithAction:seq];
		
		[_button runAction:_rep];
		CCLOG(@"Touch Began");
		_started = YES;
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
		[_timeLabel setString:[NSString stringWithString:@"FAIL!"]];
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
		[_timeLabel setString:[NSString stringWithString:@"FAIL!"]];
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
