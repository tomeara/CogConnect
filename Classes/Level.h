//
//  Level.h
//  CogConnect
//
//  Created by German Bejarano on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScene.h"

@interface Level : NSObject {
	int _levelNum;
    int _moveRate;
    int _rotateRate;
	GameScene *_scene;
}

@property (nonatomic, assign) int levelNum;
@property (nonatomic, assign) int moveRate;
@property (nonatomic, assign) int rotateRate;
@property (nonatomic, retain) GameScene *scene;

- (id)initWithLevelNum:(int)levelNum moveRate:(int)moveRate rotateRate:(int)rotateRate scene:(GameScene*)scene;

@end
