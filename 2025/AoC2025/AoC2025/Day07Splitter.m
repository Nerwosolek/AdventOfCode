// Day07Splitter.m
// Project: AoC2025
// Created by Rappsodia Labs on 07/12/2025.
  

#import "Day07Splitter.h"

@implementation Day07Splitter

- (id)initWithRow:(int)r Col:(int)c
{
	self = [super init];
	if (self) {
		self->row = r;
		self->col = c;
	}
	return self;
}

- (BOOL)isEqual:(Day07Splitter*)object
{
		if (row == object->row && col == object->col)
			return YES;
		return NO;
}

- (NSUInteger)hash
{
	return 1000*row + col;
}
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
	return self;
}

@end
