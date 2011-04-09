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
	NSSet *_points;
	float _buttonHeight;
}

+(id) scene;
@end
