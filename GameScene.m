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
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"pop2d.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"pop2b.caf"];
		
		_fail = NO;
		
		//Set difficulty 1-10
		_difficulty = 8;
		
		//Set game time and move time
		_timer = _difficulty * 0.05f;
		_buttonScale = 1 - (_difficulty * 0.05f);
		
		_timerDisplay = [CCSprite spriteWithFile:@"timer_bg.png"];
		//_timeLabel = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:24];
		_timeLabel = [CCLabelBMFont labelWithString:@"Start" fntFile:@"whitney.fnt"];
		_buttonNode = [CCNode new];
		_cog= [CCSprite spriteWithFile:@"cog.png"];
		_button = [CCSprite spriteWithFile:@"button.png"];
		
		_screenHeightWithTimer = _screenSize.height - 260;
		
		CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
        bg.position = ccp(_screenSize.width/2, _screenSize.height/2);
        [self addChild:bg];

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
		_timer = _timer - 0.01f;
		if (_timer >= 0.01) {
			[_timeLabel setString:[NSString stringWithFormat:@"%g", _timer]];
		}else{
			if (_fail == NO) {
				[_timeLabel setString:[NSString stringWithString:@"Good"]];
			}else {
				[_timeLabel setString:[NSString stringWithString:@"FAIL!"]];
			}

		}
	}
}

-(void) registerWithTouchDispatcher{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	if(!_started){
		CGPoint startTouch = [touch locationInView: touch.view];
		startTouch = [[CCDirector sharedDirector] convertToGL: startTouch];
		startTouch = [self convertToNodeSpace:startTouch];
		CGFloat touchDistance = ccpDistance(_buttonNode.position, startTouch);
		[self cogMovement:touchDistance];
	}
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint endTouch = [touch locationInView: [touch view]];		
	endTouch = [[CCDirector sharedDirector] convertToGL: endTouch];
	endTouch = [self convertToNodeSpace:endTouch];
	CGFloat touchDistance = ccpDistance(_button.position, endTouch);
	[self cogMovement:touchDistance];
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint touchLocation = [touch locationInView: [touch view]];		
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	touchLocation = [self convertToNodeSpace:touchLocation];
	CGFloat touchDistance = ccpDistance(_buttonNode.position, touchLocation);
	[self cogMovement:touchDistance];

}

-(void) cogMovement:(CGFloat)touchOrigin{
	if(touchOrigin < _buttonHeight*.5){
		if (!_moving) {
			[[SimpleAudioEngine sharedEngine] playEffect:@"pop2d.caf"];
			[_button setTexture:[[CCTextureCache sharedTextureCache] addImage:@"button_on.png"]];
			
			id ballMove1 = [CCMoveTo actionWithDuration:3 position:[self getRandomPointOnScreen]];
			id ballMove2 = [CCMoveTo actionWithDuration:3 position:[self getRandomPointOnScreen]];
			id ballMove3 = [CCMoveTo actionWithDuration:3 position:[self getRandomPointOnScreen]];
			id ballMove4 = [CCMoveTo actionWithDuration:3 position:_buttonNode.position];
			
			id seq = [CCSequence actions: ballMove1, ballMove2, ballMove3, ballMove4, nil];
			id moveEase = [CCEaseInOut actionWithAction:seq rate:_difficulty];
			_rep = [CCRepeatForever actionWithAction:moveEase];
			[_buttonNode runAction:_rep];
			
			id cogRotate = [CCRotateBy actionWithDuration:(11 - _difficulty) angle:360];
			_cogRepeat = [CCRepeatForever actionWithAction:cogRotate];
			[_cog runAction:_cogRepeat];
			
			_moving = YES;
			_started = YES;
		}
	}else{
		if (_moving) {
			[[SimpleAudioEngine sharedEngine] playEffect:@"pop2b.caf"];
			[_button setTexture:[[CCTextureCache sharedTextureCache] addImage:@"button.png"]];
			
			[_cog stopAction:_cogRepeat];
			_moving = NO;
			if (_timer >= 0.01) {
				_fail = YES;
			}else {
				_difficulty++;
			}

		}
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
