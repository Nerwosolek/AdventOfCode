// Day03.m
// Project: AoC2025
// Created by Rappsodia Labs on 03/12/2025.
  
#import <stdint.h>
#import "Day03.h"

@implementation Day03
- (id) initWithFile:(NSString*)resourceName {
	self = [super init];
	if (self) {
		NSString *filepath = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"txt"];
		NSLog(@"path = %@", filepath);
		NSError *error;
		input = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
		
		if (error)
			NSLog(@"Error reading file: %@", error.localizedDescription);
	}
	return self;
}

-(void)parseInput
{
	banks = [input componentsSeparatedByString:@"\n"];
	banks = [banks objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [banks count] - 1)]];
	NSLog(@"items count = %lu", (unsigned long)[banks count]);
	NSLog(@"item 0: %@", [banks objectAtIndex:0]);
	NSLog(@"item lastIndex: %@", [banks objectAtIndex:[banks count]-1]);
	NSLog(@"item lastIndex-1: %@", [banks objectAtIndex:[banks count]-2]);
}

- (void)solve
{
	total = 0;
	for (int b = 0; b < [banks count]; b++) {
		int tenDigit = 0;
		int tenDigitIndex = 0;
		NSString * bank = [banks objectAtIndex:b];
		int d;
		for (d = 0; d < [bank length] - 1; d++) {
			int currDigit = (int)[[bank substringWithRange:NSMakeRange(d, 1)] integerValue];
			if (currDigit > tenDigit) {
				tenDigit = currDigit;
				tenDigitIndex = d;
			}
		}
		int oneDigit = (int)[[bank substringWithRange:NSMakeRange(tenDigitIndex+1, 1)] integerValue];
		int oneDigitIndex = tenDigitIndex+1;
		for (int d2 = oneDigitIndex+1; d2 < [bank length]; d2++) {
			int currDigit = (int)[[bank substringWithRange:NSMakeRange(d2, 1)] integerValue];
			if (currDigit > oneDigit) {
				oneDigit = currDigit;
//				oneDigitIndex = d2;
			}
		}
		int joltage = tenDigit * 10 + oneDigit;
		total += joltage;
	}
	NSLog(@"total = %lu", total);
}

- (void)solve2
{
	total = 0;
	for (int b = 0; b < [banks count]; b++) {
		NSUInteger joltage = 0;
		NSString * bank = [banks objectAtIndex:b];
		int digit = 0;
		int digitIndex = -1;
		for (int poz = 0; poz < 12; poz++) {
			digit = 0;
			for (int d = digitIndex + 1; d < [bank length] - 11 + poz; d++) {
				int currDigit = (int)[[bank substringWithRange:NSMakeRange(d, 1)] integerValue];
				if (currDigit > digit) {
					digit = currDigit;
					digitIndex = d;
				}
			}
			joltage = joltage * 10 + digit;
		}
		total += joltage;
		NSLog(@"joltage nr %i = %ld", b, joltage);
	}
	NSLog(@"total = %lu", total);
	NSLog(@"max int32 %i", INT32_MAX);
	NSLog(@"max uint64 %llu", UINT64_MAX);
	NSLog(@"max ulong %lu", ULONG_MAX);
	
}

@end
