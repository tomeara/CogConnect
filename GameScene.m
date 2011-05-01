//
//  GameScene.m
//  CogConnect
//
//  Created by Edward O'Meara on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "SimpleAudioEngine.h"

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

		_screenSize = [[CCDirector sharedDirector] winSize];
		
		_fail = NO;
		
		_timerDisplay = [CCSprite spriteWithFile:@"timer_bg.png"];
		//_timeLabel = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:24];
		_timeLabel = [CCLabelBMFont labelWithString:@"Timer" fntFile:@"whitney.fnt"];
		_buttonNode = [CCNode new];
		_cog= [CCSprite spriteWithFile:@"cog.png"];
		_button = [CCSprite spriteWithFile:@"button.png"];
		
		_screenHeightWithTimer = _screenSize.height - 260;
		
		CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
        bg.position = ccp(_screenSize.width/2, _screenSize.height/2);
        [self addChild:bg];
		
		//Set game time and move time
		_timer = 0.05;
		_buttonScale = 1;

		//Set the node
		_buttonNode.scale = _buttonScale;
		_buttonNode.position = CGPointMake(_screenSize.width / 2, _screenHeightWithTimer /2);
		[self addChild:_buttonNode];
		
		//Set the cog
		[_buttonNode addChild:_cog z:0 tag:1];
		[_buttonNode addChild:_button z:1 tag:2];

		_buttonHeight = [_button texture].pixelsHigh*_buttonScale;
		
		_timerDisplay.position = CGPointMake(_screenSize.width / 2, _screenSize.height - 130);
		[self addChild:_timerDisplay z:2];
		_timeLabel.position = CGPointMake(_screenSize.width / 2, 130);
		[_timerDisplay addChild:_timeLabel z:3 tag:5];										   
													   
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
		_timer = _timer - 0.01;
		if (_timer > 0) {
			[_timeLabel setString:[NSString stringWithFormat:@"%g", _timer]];
		}else{
			if (_fail == NO) {
				[_timeLabel setString:[NSString stringWithString:@"Good"]];
			}
		}
	}
}

-(void) registerWithTouchDispatcher{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	[_button setTexture:[[CCTextureCache sharedTextureCache] addImage:@"button_on.png"]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"pop2d.wav"];
	if(!_started){
		CGPoint startTouch = [touch locationInView: touch.view];
		startTouch = [[CCDirector sharedDirector] convertToGL: startTouch];
		startTouch = [self convertToNodeSpace:startTouch];
		
		CGFloat touchDistance = ccpDistance(_buttonNode.position, startTouch);
		if(touchDistance < _buttonHeight*.5){
			//CCMoveTo *move = [CCMoveTo actionWithDuration:_timer position:CGPointMake(_screenSize.width - _buttonHeight, _screenSize.height - _buttonHeight)];
			//Bezier Curve Simulation
			
			//You can choose the two control point location as well as the endposition location as the way you wish.
			//cpShape *square = [smgr addPolyAt:cpv(240,160) mass:100 rotation:0 numPoints:4 points:cpv(0, -10), cpv(10, 0), cpv(0, 10), cpv(-10, 0)];
			//int bezierTotalPoints = 3;
			
			id ballMove1 = [CCMoveTo actionWithDuration:3 position:[self getRandomPointOnScreen]];
			id ballMove2 = [CCMoveTo actionWithDuration:3 position:[self getRandomPointOnScreen]];
			id ballMove3 = [CCMoveTo actionWithDuration:3 position:[self getRandomPointOnScreen]];
			id ballMove4 = [CCMoveTo actionWithDuration:3 position:_buttonNode.position];
			
			id seq = [CCSequence actions: ballMove1, ballMove2, ballMove3, ballMove4, nil];
			
			id moveEase = [CCEaseInOut actionWithAction:seq rate:2];
			
			_rep = [CCRepeatForever actionWithAction:moveEase];
			
			[_buttonNode runAction:_rep];
			
			id cogRotate = [CCRotateBy actionWithDuration:5 angle:360];
			
			id cogRepeat = [CCRepeatForever actionWithAction:cogRotate];
			
			[_cog runAction:cogRepeat];
			
			CCLOG(@"Touch Began");
			_started = YES;
		}
	}
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	[_button setTexture:[[CCTextureCache sharedTextureCache] addImage:@"button.png"]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"pop2b.wav"];
	CGPoint endTouch = [touch locationInView: [touch view]];		
	endTouch = [[CCDirector sharedDirector] convertToGL: endTouch];
	endTouch = [self convertToNodeSpace:endTouch];
	CCLOG(@"Touch Ended");
	
	CGFloat touchDistance = ccpDistance(_button.position, endTouch);
	if(touchDistance < _buttonHeight*.5){
		CCLOG(@"Success");
		_fail = NO;
		_started = NO;
	}else{
		CCLOG(@"Fail");
		_buttonNode.position = CGPointMake(_screenSize.width / 2, _screenHeightWithTimer /2);
		[_timeLabel setString:[NSString stringWithString:@"FAIL!"]];
		_fail = YES;
		_started = NO;
	}
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint touchLocation = [touch locationInView: [touch view]];		
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	touchLocation = [self convertToNodeSpace:touchLocation];
	CGFloat touchDistance = ccpDistance(_buttonNode.position, touchLocation);
	//CCLOG(@"Button: %@ | Touch: %@", NSStringFromCGPoint(_button.position), NSStringFromCGPoint(touchLocation));
	if(touchDistance < _buttonHeight*.5){
		[_button setTexture:[[CCTextureCache sharedTextureCache] addImage:@"button_on.png"]];
	}else {
		[_button setTexture:[[CCTextureCache sharedTextureCache] addImage:@"button.png"]];
	}

}

-(CGPoint) getRandomPointOnScreen{
	
	int randomX = arc4random() % (((int) _screenSize.width)-_buttonHeight);
	int randomY = arc4random() % (((int) _screenHeightWithTimer)-_buttonHeight);
	CGPoint randomPoint = ccp(randomX+_buttonHeight/2, randomY+_buttonHeight/2);
	CCLOG(@"x: %d, y: %d", randomX+_buttonHeight/2, randomY+_buttonHeight/2);
	return randomPoint;
}

-(void) dealloc{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	[super dealloc];
}

@end
