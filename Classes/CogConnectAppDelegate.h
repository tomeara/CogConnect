//
//  CogConnectAppDelegate.h
//  CogConnect
//
//  Created by Edward O'Meara on 3/29/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Level.h"

@class RootViewController;

@interface CogConnectAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
	int _difficulty;
	NSMutableArray *levels;
	int _curLevelIndex;

}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) NSMutableArray *levels;

- (Level *)curLevel;
- (void)loadNewLevelScene;
- (void)levelComplete;

@end
