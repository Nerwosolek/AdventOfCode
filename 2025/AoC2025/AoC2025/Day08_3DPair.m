// Day08_3DPair.m
// Project: AoC2025
// Created by Rappsodia Labs on 09/12/2025.
  

#import "Day08_3DPair.h"

@implementation Day08_3DPair

- (id)initWithPoint1:(Day083DPoint *)p1 Point2:(Day083DPoint *)p2
{
	self = [super init];
	if (self) {
		[self setPoint1:p1];
		[self setPoint2:p2];
		[self setDist:[p1 sqDist:p2]];
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"point1: %@, point2 %@, squared distance = %lu", _point1, _point2, _dist];
}

@end
