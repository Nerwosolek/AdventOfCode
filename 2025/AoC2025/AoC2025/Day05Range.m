// Day05Range.m
// Project: AoC2025
// Created by Rappsodia Labs on 05/12/2025.
  

#import "Day05Range.h"

@implementation Day05Range

- (id)initWithLeft:(NSUInteger)l right:(NSUInteger)r
{
	self = [super init];
	if (self) {
		if (l > r) return nil;
		[self setLeft:l];
		[self setRight:r];
	}
	return self;
}

- (id)initWithString:(NSString*)rangeStr
{
	NSArray *range = [rangeStr componentsSeparatedByString:@"-"];
	NSUInteger lower = [[range objectAtIndex:0] integerValue];
	NSUInteger upper = [[range objectAtIndex:1] integerValue];
	return [self initWithLeft:lower right:upper];
}

@end
