// Day01.m
// Project: AoC2025
// Created by Rappsodia Labs on 01/12/2025.
  
#import "Day01.h"

@implementation Day01

- (id) initWithFile:(NSString*)resourceName {
	self = [super init];
	if (self) {
		NSString *filepath = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"txt"];
		NSLog(@"path = %@", filepath);
		NSError *error;
		NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
		
		if (error)
			NSLog(@"Error reading file: %@", error.localizedDescription);
		
		// maybe for debugging...
		//NSLog(@"contents: %@", fileContents);
		
		rotations = [fileContents componentsSeparatedByString:@"\n"];
		NSLog(@"items = %lu", (unsigned long)[rotations count]);
		NSLog(@"item 0: %@", [rotations objectAtIndex:0]);
		NSLog(@"item lastIndex: %@", [rotations objectAtIndex:[rotations count]-1]);
		NSLog(@"item lastIndex-1: %@", [rotations objectAtIndex:[rotations count]-2]);
		
		counter = 0;
	}
	return self;
}
- (NSUInteger)countZeros {
	NSInteger dial = 50;
	counter = 0;
	for (int i = 0; i < [rotations count]; i++) {
		NSString *rot = [rotations objectAtIndex:i];
		if (rot != nil &&	 [rot length] != 0) {
			NSString *dir = [rot substringToIndex:1];
			NSString *amount = [rot substringFromIndex:1];
			NSUInteger clicks = [amount integerValue];
			clicks = clicks % 100;
			if ([dir isEqualToString:@"R"]) {
				dial = (dial + clicks) % 100;
			} else {
				dial = dial - clicks;
				if (dial < 0) dial = 100 + dial;
			}
			if (dial == 0) counter++;
		}
	}
	return counter;
}

- (NSUInteger)countThroughZeros {
	NSInteger dial = 50;
	counter = 0;
	for (int i = 0; i < [rotations count]; i++) {
		NSString *rot = [rotations objectAtIndex:i];
		if (rot != nil && [rot length] != 0) {
			NSString *dir = [rot substringToIndex:1];
			NSString *amount = [rot substringFromIndex:1];
			NSInteger clicks = [amount integerValue];
			NSInteger allClicks = clicks;
			clicks = clicks % 100;
			if ([dir isEqualToString:@"R"]) {
				counter += (allClicks) / 100;
				if (dial + clicks > 99) counter++;
				dial = (dial + clicks) % 100;
			} else {
				counter += (allClicks) / 100;
				if (dial - clicks < 1) {
					if (dial != 0) counter++;
					dial = (dial + 100 - clicks) % 100;
				} else {
					dial = dial - clicks;
				}
			}
//			for (int r = 0; r < allClicks; r++) {
//				if ([dir isEqualToString:@"R"]) {
//					dial++;
//				} else {
//					dial--;
//				}
//				if (dial % 100 == 0) counter++;
//			}
		}
	}
	return counter;
}

@end
