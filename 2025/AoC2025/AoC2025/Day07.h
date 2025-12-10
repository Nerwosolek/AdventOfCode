// Day07.h
// Project: AoC2025
// Created by Rappsodia Labs on 07/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day07 : NSObject {
	NSString *input;
	NSArray *rows;
	NSMutableSet *splitters;
	NSMutableDictionary *splitTimelines;
	NSUInteger splitCount;
	NSUInteger pathCount;
}

- (id)initWithFile:(NSString*)resourceName;
- (void)parseInput;
- (void)solve;
- (void)solve2;

@end

NS_ASSUME_NONNULL_END
