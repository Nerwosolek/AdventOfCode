// Day04.m
// Project: AoC2025
// Created by Rappsodia Labs on 04/12/2025.
  

#import "Day04.h"

@implementation Day04
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
	rows = [rows objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [rows count] - 1)]];
	NSMutableArray *rowsPadded = [[NSMutableArray alloc] init];
	NSString *emptyRow = [[NSString alloc] init];
	emptyRow = [emptyRow stringByPaddingToLength:138 withString:@"." startingAtIndex:0];
//	NSLog(@"%@", emptyRow);
	[rowsPadded addObject:emptyRow];
	for (int r = 0; r < [rows count]; r++) {
		[rowsPadded addObject:[NSString stringWithFormat:@".%@.", [rows objectAtIndex:r]]];
	}
	[rowsPadded addObject:emptyRow];
	rows = [rowsPadded copy];
	NSLog(@"max int32 %i", INT32_MAX);
	NSLog(@"max uint64 %llu", UINT64_MAX);
	NSLog(@"max ulong %lu", ULONG_MAX);
//	NSLog(@"items count = %lu", (unsigned long)[rows count]);
//	NSLog(@"item 0: %@", [rows objectAtIndex:0]);
//	NSLog(@"item lastIndex: %@", [rows objectAtIndex:[rows count]-1]);
//	NSLog(@"item lastIndex-1: %@", [rows objectAtIndex:[rows count]-2]);
}

-(void)solve
{
	total = 0;
	int neigh = 0;
	unichar małpa = [@"@" characterAtIndex:0];
	for(int r = 1; r < 137; r++) {
		for (int c = 1; c < 137; c++) {
			unichar me = [[rows objectAtIndex:r] characterAtIndex:c];
			if (me == małpa)
			{
				neigh = 0;
				for (int i = 0; i < 3; i++) {
					for (int j = 0; j < 3; j++) {
						unichar ch = [[rows objectAtIndex:r-1+i] characterAtIndex:c-1+j];
						if(ch == małpa) neigh++;
					}
				}
				neigh--;
				if (neigh < 4) total++;
			}
		}
	}
	NSLog(@"total = %lu", total);
}

- (void)solve2
{
	total = 0;
	NSUInteger subTotal = 0;
	unichar małpa = [@"@" characterAtIndex:0];
	NSMutableArray *currRows = [rows mutableCopy];
	NSMutableArray *newRows = [currRows mutableCopy];
	do {
		subTotal = 0;
		
		int neigh = 0;
		for(int r = 1; r < 137; r++) {
			for (int c = 1; c < 137; c++) {
				unichar me = [[currRows objectAtIndex:r] characterAtIndex:c];
				if (me == małpa)
				{
					neigh = 0;
					for (int i = 0; i < 3; i++) {
						for (int j = 0; j < 3; j++) {
							unichar ch = [[currRows objectAtIndex:r-1+i] characterAtIndex:c-1+j];
							if(ch == małpa) neigh++;
						}
					}
					neigh--;
					if (neigh < 4) {
						subTotal++;
						NSString *oldRow = [newRows objectAtIndex:r];
						NSString *newRow = [oldRow stringByReplacingCharactersInRange:NSMakeRange(c, 1) withString:@"."];
						[newRows replaceObjectAtIndex:r withObject:newRow];
					}
				}
			}
		}
		NSLog(@"SubTotal = %lu", subTotal);
		total += subTotal;
		currRows = [newRows mutableCopy];
	} while (subTotal > 0);
	NSLog(@"total = %lu", total);
}
@end
