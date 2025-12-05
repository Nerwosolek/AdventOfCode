// Day05.h
// Project: AoC2025
// Created by Rappsodia Labs on 05/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day05 : NSObject {
	NSString *input;
	NSArray *ranges;
	NSArray *ids;
	NSUInteger total;
}

- (id)initWithFile:(NSString*)resourceName;
- (void)parseInput;
- (void)solve;
- (void)solve2;


@end

NS_ASSUME_NONNULL_END
