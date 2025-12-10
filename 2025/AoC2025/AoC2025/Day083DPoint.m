// Day083DPoint.m
// Project: AoC2025
// Created by Rappsodia Labs on 09/12/2025.
  

#import "Day083DPoint.h"
#import <math.h>

@implementation Day083DPoint

- (id)initWithX:(NSUInteger)x WithY:(NSUInteger)y WithZ:(NSUInteger)z
{
	self = [super init];
	if (self) {
		[self setX:x];
		[self setY:y];
		[self setZ:z];
	}
	return self;
}

- (NSUInteger)sqDist:(Day083DPoint *)point
{
	return (self->_x - point->_x) * (self->_x - point->_x) + (self->_y - point->_y) * (self->_y - point->_y) + (self->_z - point->_z) * (self->_z - point->_z);
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"x: %lu, y: %lu, z: %lu", _x, _y, _z];
}

- (BOOL)isEqual:(id)object
{
	if ([object isMemberOfClass:[self class]]) {
		object = (Day083DPoint*)object;
		if ([object x] == [self x] && [object y] == [self y] && [object z] == [self z])
			return YES;
	}
	return NO;
}

@end
