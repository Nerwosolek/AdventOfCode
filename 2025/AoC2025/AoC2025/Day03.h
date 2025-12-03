// Day03.h
// Project: AoC2025
// Created by Rappsodia Labs on 03/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day03 : NSObject {
	NSString *input;
	NSArray *banks;
	NSUInteger total;
}

- (id)initWithFile:(NSString*)resourceName;
- (void)parseInput;
- (void)solve;
- (void)solve2;


@end

NS_ASSUME_NONNULL_END
