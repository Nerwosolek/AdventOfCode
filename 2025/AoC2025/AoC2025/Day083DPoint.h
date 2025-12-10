// Day083DPoint.h
// Project: AoC2025
// Created by Rappsodia Labs on 09/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day083DPoint : NSObject
@property NSUInteger x;
@property NSUInteger y;
@property NSUInteger z;
- (id)initWithX:(NSUInteger)x WithY:(NSUInteger)y WithZ:(NSUInteger)z;
- (NSUInteger)sqDist:(Day083DPoint *)point;

@end

NS_ASSUME_NONNULL_END
