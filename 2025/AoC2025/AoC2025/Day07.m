// Day07.m
// Project: AoC2025
// Created by Rappsodia Labs on 07/12/2025.
  

#import "Day07.h"
#import "Day07Splitter.h"

@implementation Day07
- (id) initWithFile:(NSString*)resourceName {
	self = [super init];
	if (self) {
		NSString *filepath = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"txt"];
//		NSLog(@"path = %@", filepath);
		NSError *error;
		input = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
		
		if (error)
			NSLog(@"Error reading file: %@", error.localizedDescription);
		splitters = [[NSMutableSet alloc] init];
		splitTimelines = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)parseInput
{
	rows = [input componentsSeparatedByString:@"\n"];
	rows = [rows subarrayWithRange:NSMakeRange(0, [rows count] - 1)];
	NSLog(@"rows count = %lu", [rows count]);
}

- (void)solve
{
	splitCount = 0;
	int row = 0;
	int col = 0;
	col = (int)[[rows objectAtIndex:row] rangeOfString:@"S"].location;
	NSLog(@"S at: %i", col);
	[self beamSearchStartRow:row startCol:col];
	NSLog(@"splitCount %lu", splitCount);
}

- (void)beamSearchStartRow:(int)r startCol:(int)c
{
	if (r < [rows count] - 1) {
//	if (r < 9) {
		NSString *ch = [[rows objectAtIndex:r+1] substringWithRange:NSMakeRange(c, 1)];
		if ([ch isEqualToString:@"."]) {
			[self beamSearchStartRow:r+1 startCol:c];
		} else {
			Day07Splitter* foundSplitter = [[Day07Splitter alloc] initWithRow:r+1 Col:c];
			if (![splitters containsObject:foundSplitter]) {
				[splitters addObject:foundSplitter];
				splitCount++;
				[self beamSearchStartRow:r+1 startCol:c-1];
				[self beamSearchStartRow:r+1 startCol:c+1];
			}
		}
	}
}

- (void)solve2
{
	pathCount = 0;
	int row = 0;
	int col = 0;
	col = (int)[[rows objectAtIndex:row] rangeOfString:@"S"].location;
	pathCount = [self binSearchRow:row column:col];
	NSLog(@"pathCount = %lu", pathCount);
}

- (NSUInteger)binSearchRow:(int)row column:(int)col
{
	if (row < [rows count] - 1) {
		NSString *ch = [[rows objectAtIndex:row+1] substringWithRange:NSMakeRange(col, 1)];
		if ([ch isEqualToString:@"."]) {
			return [self binSearchRow:row+1 column:col];
		} else {
			Day07Splitter* foundSplitter = [[Day07Splitter alloc] initWithRow:row+1 Col:col];
			NSNumber *timelineCnt = [splitTimelines objectForKey:foundSplitter];
			if (timelineCnt == nil) {
				NSUInteger leftCount = [self binSearchRow:row+1 column:col-1];
				NSUInteger rightCount = [self binSearchRow:row+1 column:col+1];
				[splitTimelines setObject:[NSNumber numberWithUnsignedInteger:(leftCount + rightCount)] forKey:foundSplitter];
				NSLog(@"row: %i, col: %i, sum: %lu", row+1, col, leftCount + rightCount);
				return leftCount + rightCount;
			} else {
				return [timelineCnt unsignedIntegerValue];
			}
		}
	 
	}
	return 1;
}

@end
