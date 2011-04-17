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
	CCSprite *_button;
	float _buttonHeight;
	CGSize _screenSize;
	int _timer;
	float _buttonScale;
	id _rep;
	CCLabelTTF *_timeLabel;
	bool _started;
}

+(id) scene;
-(CGPoint) getRandomPointOnScreen;
@end
