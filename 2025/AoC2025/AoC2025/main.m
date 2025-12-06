// main.m
// Project: AoC2025
// Created by Rappsodia Labs on 01/12/2025.
  

#import <Foundation/Foundation.h>
#import "Day01.h"
#import "Day02.h"
#import "Day03.h"
#import "Day04.h"
#import "Day05.h"
#import "Day06.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
//		Day01* solver = [[Day01 alloc] initWithFile:@"input01"];
//		NSLog(@"Day01 star 1: %lu", [solver countZeros]);
//		NSLog(@"Day01 star 2: %lu", [solver countThroughZeros]);
//		NSLog(@"%d", -1200 % 100);
//		Day02 *solver2 = [[Day02 alloc] initWithFile:@"input02"];
//		[solver2 parseInput];
//		[solver2 solve];
//		[solver2 solve2];
		
//		Day03 *solver3 = [[Day03 alloc] initWithFile:@"input03"];
//		[solver3 parseInput];
//		[solver3 solve];
//		[solver3 solve2];
		
//		Day04 *solver4 = [[Day04 alloc] initWithFile:@"input04"];
//		[solver4 parseInput];
//		[solver4 solve];
//		[solver4 solve2];
		
//		Day05 *solver5 = [[Day05 alloc] initWithFile:@"input05"];
//		[solver5 parseInput];
//		[solver5 solve];
//		[solver5 solve2];
		
		Day06 *solver6 = [[Day06 alloc] initWithFile:@"input06"];
		[solver6 parseInput];
		[solver6 solve];
		[solver6 parseInput2];
		[solver6 solve];
	}
	return 0;
}
