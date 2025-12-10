// Day07Splitter.h
// Project: AoC2025
// Created by Rappsodia Labs on 07/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day07Splitter : NSObject<NSCopying> {
	int row;
	int col;
}

- (BOOL)isEqual:(id)object;
- (id)initWithRow:(int)r Col:(int)c;

@end

NS_ASSUME_NONNULL_END
