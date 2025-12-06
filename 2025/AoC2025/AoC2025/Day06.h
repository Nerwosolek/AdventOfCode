// Day06.h
// Project: AoC2025
// Created by Rappsodia Labs on 06/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day06 : NSObject {
	NSString *input;
	NSArray *rows;
	NSMutableArray *problems;
	NSUInteger grandTotal;
}

- (id)initWithFile:(NSString*)resourceName;
- (void)parseInput;
- (void)parseInput2;
- (void)solve;
- (void)solve2;

@end

NS_ASSUME_NONNULL_END
