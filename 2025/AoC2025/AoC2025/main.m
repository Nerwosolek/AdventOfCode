// main.m
// Project: AoC2025
// Created by Rappsodia Labs on 01/12/2025.
  

#import <Foundation/Foundation.h>
#import "Day01.h"
#import "Day02.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
//		Day01* solver = [[Day01 alloc] initWithFile:@"input01"];
//		NSLog(@"Day01 star 1: %lu", [solver countZeros]);
//		NSLog(@"Day01 star 2: %lu", [solver countThroughZeros]);
//		NSLog(@"%d", -1200 % 100);
		Day02 *solver2 = [[Day02 alloc] initWithFile:@"input02"];
		[solver2 parseInput];
		
	}
	return 0;
}
