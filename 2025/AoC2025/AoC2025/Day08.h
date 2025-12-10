// Day08.h
// Project: AoC2025
// Created by Rappsodia Labs on 08/12/2025.
  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Day08 : NSObject {
	NSString *input;
	NSMutableArray *positions; // make 3DPoint class.
	NSMutableArray *pairs;
	NSMutableArray *circuits;
	NSMutableSet* visitedPoints;
	NSMutableArray* subCircuitsSizes;
	NSMutableArray* nodeSets;
}

- (id)initWithFile:(NSString*)resourceName;
- (void)parseInput;
- (void)solve;
- (void)continueCreateCircuits;

@end

NS_ASSUME_NONNULL_END
