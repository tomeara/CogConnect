//
//  Global.h
//  CogConnect
//
//  Created by Edward O'Meara on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Global : NSObject {
	int _difficulty;
	bool _first;
}
-(int)upgradeDifficulty;

@end
