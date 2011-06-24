//
//  GameScene.h
//  CogConnect
//
//  Created by Edward O'Meara on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Test.h"

@interface GameScene : CCLayer {
	CCNode *_buttonNode;
	CCSprite *_button;
	CCSprite *_cog;
	CCSprite *_timerDisplay;
	CCLabelBMFont *_timeLabel;
	CGSize _screenSize;
	int _buttonHeight;
	int _screenHeightWithTimer;
	int _difficulty;
	double _timer;
	float _buttonScale;
	id _rep;
	id _cogRepeat;
	bool _started;
	bool _moving;
	bool _fail;
	NSMutableArray *_touchPercentages;
	NSDate *_start;
	int _numberOfTries;
}

@property (nonatomic,retain) NSMutableArray *_touchPercentages;
@property (nonatomic,retain) NSDate *_start;

+(id) scene;
-(CGPoint) getRandomPointOnScreen;
-(void) cogMovement:(CGFloat)touchOrigin;
@end
