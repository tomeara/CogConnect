//
//  GameScene.h
//  CogConnect
//
//  Created by Edward O'Meara on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameScene : CCLayer {
	CCNode *_buttonNode;
	CCSprite *_button;
	CCSprite *_cog;
	CCSprite *_timerDisplay;
	int _buttonHeight;
	CGSize _screenSize;
	int _screenHeightWithTimer;
	double _timer;
	float _buttonScale;
	id _rep;
	CCLabelBMFont *_timeLabel;
	bool _started;
	bool _fail;
}

+(id) scene;
-(CGPoint) getRandomPointOnScreen;
@end
