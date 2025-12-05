// Day04.h
// Project: AoC2025
// Created by Rappsodia Labs on 04/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day04 : NSObject {
	NSString *input;
	NSArray *rows;
	NSUInteger total;
}

- (id)initWithFile:(NSString*)resourceName;
- (void)parseInput;
- (void)solve;
- (void)solve2;

@end

NS_ASSUME_NONNULL_END
