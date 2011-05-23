//
//  Global.m
//  CogConnect
//
//  Created by Edward O'Meara on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Global.h"


@implementation Global

-(int)upgradeDifficulty{
	if (!_first) {
		_difficulty = 1;
		_first = YES;
	}else{
		++_difficulty;
	}
	return _difficulty;
}

@end
