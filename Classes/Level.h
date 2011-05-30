//
//  Level.h
//  CogConnect
//
//  Created by German Bejarano on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScene.h"
#import "TestLevel.h"

@interface Level : NSObject {
	int _levelNum;
    int _moveRate;
    int _rotateRate;
	float _buttonScale;
	float _timeSpan;
	Class _scene;
	TestLevel *_currentTestLevel;
}

@property (nonatomic, assign) int levelNum;
@property (nonatomic, assign) int moveRate;
@property (nonatomic, assign) int rotateRate;
@property (nonatomic, assign) float buttonScale;
@property (nonatomic, assign) float timeSpan;
@property (nonatomic, assign) Class scene;
@property (nonatomic, retain) TestLevel *currentTestLevel;

- (id)initWithLevelNum:(int)levelNum moveRate:(int)moveRate rotateRate:(int)rotateRate buttonScale:(float)buttonScale timeSpan:(float)timeSpan scene:(Class)scene;

@end
