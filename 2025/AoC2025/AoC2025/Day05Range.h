// Day05Range.h
// Project: AoC2025
// Created by Rappsodia Labs on 05/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day05Range : NSObject

@property NSUInteger left;
@property NSUInteger right;

- (id)initWithLeft:(NSUInteger)l right:(NSUInteger)r;
- (id)initWithString:(NSString*)rangeStr;

@end

NS_ASSUME_NONNULL_END
