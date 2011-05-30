//
//  NSMutableArray+getAverage.m
//  CogConnect
//
//  Created by German Bejarano on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+getAverage.h"


@implementation NSMutableArray (getAverage)

-(float)getAverage{
	NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:@"0.0"];
	for (NSDecimalNumber *currentNumber in self) {
		total = [total decimalNumberByAdding:currentNumber];
	}
	return [[total decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.6f",[[NSNumber numberWithInt:[self count]] floatValue]]]] floatValue];
}

@end
