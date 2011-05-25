//
//  Level.m
//  CogConnect
//
//  Created by German Bejarano on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level.h"


@implementation Level

@synthesize moveRate = _moveRate;
@synthesize levelNum = _levelNum;
@synthesize rotateRate = _rotateRate;
@synthesize scene = _scene;

- (id)initWithLevelNum:(int)levelNum moveRate:(int)moveRate rotateRate:(int)rotateRate scene:(GameScene*)scene{
	if ((self = [super init])) {
        self.levelNum = levelNum;
        self.moveRate = moveRate;
        self.rotateRate = rotateRate;
		self.scene = scene;
    }
    
    return self;
}

@end
