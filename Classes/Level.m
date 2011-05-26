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
@synthesize buttonScale = _buttonScale;
@synthesize timeSpan = _timeSpan;
@synthesize scene = _scene;

- (id)initWithLevelNum:(int)levelNum moveRate:(int)moveRate rotateRate:(int)rotateRate buttonScale:(float)buttonScale timeSpan:(float)timeSpan scene:(Class)scene{
	if ((self = [super init])) {
        self.levelNum = levelNum;
        self.moveRate = moveRate;
        self.rotateRate = rotateRate;
		self.buttonScale = buttonScale;
		self.timeSpan = timeSpan;
		self.scene = scene;
    }
    
    return self;
}

@end
