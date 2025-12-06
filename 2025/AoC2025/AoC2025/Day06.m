// Day06.m
// Project: AoC2025
// Created by Rappsodia Labs on 06/12/2025.
  

#import "Day06.h"

@implementation Day06

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
	rows = [input componentsSeparatedByString:@"\n"];
//	for(int l = 0; l < [lines count]; l++) {
//		NSString *line = [lines objectAtIndex:l];
//		if (line == nil || [line isEqualToString:@""]) {
//			NSLog(@"empty line index %i", l);
//		}
//	}
	NSArray *row = [[rows objectAtIndex:0] componentsSeparatedByString:@" "];
	NSString *empty = [row objectAtIndex:[row count] - 3];
	NSMutableArray *mutableRow = [row mutableCopy];
	[mutableRow removeObjectIdenticalTo:empty];
	NSMutableArray *problem;
	NSUInteger max = 0;
	problems = [[NSMutableArray alloc] initWithCapacity:[mutableRow count]];
	for (int i = 0; i < [mutableRow count]; i++) {
		problem = [[NSMutableArray alloc] initWithCapacity:5];
		[problem addObject:[mutableRow objectAtIndex:i]];
		NSUInteger n = [[mutableRow objectAtIndex:i] integerValue];
		if (n > max) max = n;
		[problems addObject:problem];
	}
	for(int r = 1; r < [rows count]; r++) {
		mutableRow = [[[rows objectAtIndex:r] componentsSeparatedByString:@" "] mutableCopy];
		[mutableRow removeObjectIdenticalTo:empty];
		for (int i = 0; i < [mutableRow count]; i++) {
			problem = [problems objectAtIndex:i];
			[problem addObject:[mutableRow objectAtIndex:i]];
			NSUInteger n = [[mutableRow objectAtIndex:i] integerValue];
			if (n > max) max = n;
		}
	}
	NSLog(@"max = %lu", max);
//	NSLog(@"Problem 0, operation symbol: %@", [[problems objectAtIndex:0] objectAtIndex:4]);
//	NSLog(@"Problem 999, operation symbol: %@, numbers: %lu %lu %lu %lu", [[problems objectAtIndex:999] objectAtIndex:4],
//		  [[[problems objectAtIndex:999] objectAtIndex:0] integerValue],
//		  [[[problems objectAtIndex:999] objectAtIndex:1] integerValue],
//		  [[[problems objectAtIndex:999] objectAtIndex:2] integerValue],
//		  [[[problems objectAtIndex:999] objectAtIndex:3] integerValue]);
}
- (void)parseInput2
{
	NSMutableArray *operationRow = [[[rows objectAtIndex:4] componentsSeparatedByString:@" "] mutableCopy];
	NSString *empty = [operationRow objectAtIndex:[operationRow count] - 1];
	[operationRow removeObjectIdenticalTo:empty];
//	NSLog(@"operations: %@, count: %lu", operationRow, [operationRow count]);
	NSMutableArray *problem;
	problems = [[NSMutableArray alloc] initWithCapacity:[operationRow count]];
	for (int i = 0; i < [operationRow count]; i++) {
		problem = [[NSMutableArray alloc] initWithCapacity:5];
		NSString *op = [operationRow objectAtIndex:i];
		for (int k = 0; k < 4; k++) {
			if ([op isEqualToString:@"+"]) [problem addObject:@"0"];
			else [problem addObject:@"1"];
		}
		[problem addObject:op];
		[problems addObject:problem];
	}
	int p = 0;
	int l = 0;
	for (int c = 0; c < [[rows objectAtIndex:0] length]; c++) {
		problem = [problems objectAtIndex:p];
		NSString *chs = @"";
		for (int r = 0; r < 4; r++) {
			chs = [chs stringByAppendingString:
			 [[rows objectAtIndex:r]
			  substringWithRange:NSMakeRange(c, 1)]];
		}
		// czy koniec kolumny:
		if ([chs isEqualToString:@"    "]) {
			p++;
			l = 0;
		} else {
			// wstawiamy liczbę na index l;
			// trim
			chs = [chs stringByTrimmingCharactersInSet:
			 [NSCharacterSet characterSetWithCharactersInString:@" "]];
			[problem replaceObjectAtIndex:l withObject:chs];
			l++;
		}
	}
}

- (void)solve
{
	grandTotal = 0;
	for (int p = 0; p < [problems count]; p++) {
		NSMutableArray *problem = [problems objectAtIndex:p];
		NSString *op = [problem objectAtIndex:4];
		if ([op isEqualToString:@"+"]) {
			NSUInteger sum = 0;
			for (int i = 0; i < 4; i++) {
				sum += [[problem objectAtIndex:i] integerValue];
			}
			grandTotal += sum;
		} else {
			NSUInteger prod = 1;
			for (int i = 0; i < 4; i++) {
				prod *= [[problem objectAtIndex:i] integerValue];
			}
			grandTotal += prod;
		}
	}
	NSLog(@"GrandTotal = %lu", grandTotal);
}
@end
