// Day02.m
// Project: AoC2025
// Created by Rappsodia Labs on 02/12/2025.
  

#import "Day02.h"

@implementation Day02

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
	ranges = [input componentsSeparatedByString:@","];
	NSLog(@"items count = %lu", (unsigned long)[ranges count]);
	NSLog(@"item 0: %@", [ranges objectAtIndex:0]);
	NSLog(@"item lastIndex: %@", [ranges objectAtIndex:[ranges count]-1]);
	NSLog(@"item lastIndex-1: %@", [ranges objectAtIndex:[ranges count]-2]);
}

- (void)solve
{
	result = 0;
	for(int r = 0; r < [ranges count]; r++) {
		NSString *rangeStr = [ranges objectAtIndex:r];
		NSRange dashIndex = [rangeStr rangeOfString:@"-"];
		NSRange range;
		range.location = [[rangeStr substringToIndex:dashIndex.location] integerValue];
		range.length = [[rangeStr substringFromIndex:dashIndex.location+1] integerValue] - range.location + 1;
		for (long i = range.location; i < range.location + range.length; i++) {
			NSString *idStr = [@(i) stringValue];
			if ([self isInvalidId:idStr]) result += i;
		}
	}
	NSLog(@"result = %lu", result);
}

- (BOOL)isInvalidId:(NSString *)idStr
{
	int len = (int)[idStr length];
	if (len % 2 == 0) {
		return [[idStr substringToIndex:len/2] isEqualToString:[idStr substringFromIndex:len/2]];
	}
	return NO;
}

- (void)solve2
{
	result = 0;
	for(int r = 0; r < [ranges count]; r++) {
		NSString *rangeStr = [ranges objectAtIndex:r];
		NSRange dashIndex = [rangeStr rangeOfString:@"-"];
		NSRange range;
		range.location = [[rangeStr substringToIndex:dashIndex.location] integerValue];
		range.length = [[rangeStr substringFromIndex:dashIndex.location+1] integerValue] - range.location + 1;
		for (long i = range.location; i < range.location + range.length; i++) {
			NSString *idStr = [@(i) stringValue];
			if ([self isInvalidId2:idStr]) result += i;
		}
	}
	NSLog(@"result = %lu", result);
}

- (BOOL)isInvalidId2:(NSString *)idStr
{
	int len = (int)[idStr length];
	BOOL res = NO;
	for (int c = 1; c < len/2 + 1; c++) {
		if (len % c == 0) {
			int cnt = len / c;
			for (int pc = 0; pc < cnt - 1; pc++) {
				NSRange rn = NSMakeRange(pc * c, c);
				res = [[idStr substringWithRange:rn] isEqualToString:[idStr substringWithRange:NSMakeRange(rn.location + c, c)]];
				if (res == NO) break;
			}
			if (res == YES) return YES;
		}
	}
	return NO;
}


@end
