// Day05.m
// Project: AoC2025
// Created by Rappsodia Labs on 05/12/2025.
  

#import "Day05.h"
#import "Day05Range.h"

@implementation Day05
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
	NSArray *lines = [input componentsSeparatedByString:@"\n"];
//	for(int l = 0; l < [lines count]; l++) {
//		NSString *line = [lines objectAtIndex:l];
//		if (line == nil || [line isEqualToString:@""]) {
//			NSLog(@"empty line index %i", l);
//		}
//	}
	ranges = [lines objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 181)]];
	ids = [lines objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(182, 1000)]];
	NSLog(@"ranges[0] : %@", [ranges objectAtIndex:0]);
	NSLog(@"ranges[lastIndex], lastIndex : %@, %lu", [ranges objectAtIndex:[ranges count] - 1], [ranges count] - 1);
	
	NSLog(@"ids[0] : %@", [ids objectAtIndex:0]);
	NSLog(@"ids[lastIndex], lastIndex : %@, %lu", [ids objectAtIndex:[ids count] - 1], [ids count] - 1);
	
}

- (void)solve
{
	total = 0;
	for (int i = 0; i < [ids count]; i++) {
		NSUInteger id = [[ids objectAtIndex:i] integerValue];
		for (int r = 0; r < [ranges count]; r++) {
			NSArray *range = [[ranges objectAtIndex:r] componentsSeparatedByString:@"-"];
			NSUInteger lower = [[range objectAtIndex:0] integerValue];
			NSUInteger upper = [[range objectAtIndex:1] integerValue];
			if (id >= lower && id <= upper) {
				total++;
				break;
			}
		}
	}
	NSLog(@"total = %lu", total);
}

- (void)solve2
{
	total = 0;
	NSMutableArray *rangesInts = [[NSMutableArray alloc] init];
	for (int r = 0; r < [ranges count]; r++) {
		Day05Range *range = [[Day05Range alloc] initWithString:[ranges objectAtIndex:r]];
		[rangesInts addObject:range];
	}
	[rangesInts sortUsingComparator:^NSComparisonResult(Day05Range * _Nonnull obj1, Day05Range* _Nonnull obj2) {
		if (obj1.left < obj2.left) return NSOrderedAscending;
		else if (obj1.left > obj2.left) return NSOrderedDescending;
		return NSOrderedSame;
	}];
	
	int r = 1;
	NSUInteger first = [[rangesInts objectAtIndex:0] left];
	NSUInteger second = [[rangesInts objectAtIndex:0] right];
	total += second - first + 1;
	while (r < [rangesInts count]) {
		if ([[rangesInts objectAtIndex:r] right] > second) {
			NSUInteger newLeft = [[rangesInts objectAtIndex:r] left] > second ? [[rangesInts objectAtIndex:r] left] - 1 : second;
			total += [[rangesInts objectAtIndex:r] right] - newLeft;
			second = [[rangesInts objectAtIndex:r] right];
		}
		r++;
	}
	NSLog(@"total2 = %lu", total);
}
@end
