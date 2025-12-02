// Day01.h
// Project: AoC2025
// Created by Rappsodia Labs on 01/12/2025.
  

#ifndef Day01_h
#define Day01_h
#import <Foundation/Foundation.h>

@interface Day01 : NSObject {
	NSArray *rotations;
	NSUInteger counter;
}

- (id)initWithFile:(NSString*)resourceName;
- (NSUInteger)countZeros;
- (NSUInteger)countThroughZeros;


@end

#endif /* Day01_h */
