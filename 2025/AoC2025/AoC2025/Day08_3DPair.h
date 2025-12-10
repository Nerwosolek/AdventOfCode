// Day08_3DPair.h
// Project: AoC2025
// Created by Rappsodia Labs on 09/12/2025.
  

#import <Foundation/Foundation.h>
#import "Day083DPoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface Day08_3DPair : NSObject
@property Day083DPoint *point1;
@property Day083DPoint *point2;
@property NSUInteger dist;

- (id)initWithPoint1:(Day083DPoint*)p1 Point2:(Day083DPoint*)p2;

@end

NS_ASSUME_NONNULL_END
