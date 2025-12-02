// Day02.h
// Project: AoC2025
// Created by Rappsodia Labs on 02/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day02 : NSObject {
	NSString *input;
	NSArray *ranges;
	NSUInteger result;
}

- (id)initWithFile:(NSString*)resourceName;
- (void)parseInput;
- (void)solve;
- (void)solve2;

@end

NS_ASSUME_NONNULL_END
