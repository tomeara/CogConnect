//
//  Level.m
//  CogConnect
//
//  Created by German Bejarano on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level.h"
#import "TestLevel.h"
#import "ModelManager.h"

@implementation Level

@synthesize moveRate = _moveRate;
@synthesize levelNum = _levelNum;
@synthesize rotateRate = _rotateRate;
@synthesize buttonScale = _buttonScale;
@synthesize timeSpan = _timeSpan;
@synthesize scene = _scene;
@synthesize currentTestLevel = _currentTestLevel;

- (id)initWithLevelNum:(int)levelNum moveRate:(int)moveRate rotateRate:(int)rotateRate buttonScale:(float)buttonScale timeSpan:(float)timeSpan scene:(Class)scene{
	if ((self = [super init])) {
        self.levelNum = levelNum;
        self.moveRate = moveRate;
        self.rotateRate = rotateRate;
		self.buttonScale = buttonScale;
		self.timeSpan = timeSpan;
		self.scene = scene;
		
		//Creating Levels in CoreData
		TestLevel *level = [[ModelManager sharedInstance] addTestLevel];
		level.levelNumber = [NSNumber numberWithInt:levelNum];
		level.moveRate = [NSNumber numberWithInt:moveRate];
		level.rotateRate = [NSNumber numberWithFloat:rotateRate];
		level.buttonScale = [NSNumber numberWithFloat:buttonScale];
		level.timeSpan = [NSNumber numberWithFloat:timeSpan];
		[[ModelManager sharedInstance] doSave];
		
		self.currentTestLevel = level;
    }
    
    return self;
}

-(void) dealloc{
	[self.currentTestLevel release];
	[super dealloc];
}

@end
