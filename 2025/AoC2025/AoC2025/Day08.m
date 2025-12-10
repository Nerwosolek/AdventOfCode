// Day08.m
// Project: AoC2025
// Created by Rappsodia Labs on 08/12/2025.
  

#import "Day08.h"
#import "Day083DPoint.h"
#import "Day08_3DPair.h"

@implementation Day08

- (id) initWithFile:(NSString*)resourceName {
	self = [super init];
	if (self) {
		NSString *filepath = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"txt"];
//		NSLog(@"path = %@", filepath);
		NSError *error;
		input = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
		
		if (error)
			NSLog(@"Error reading file: %@", error.localizedDescription);
	}
	return self;
}

- (void)parseInput
{
	positions = [[NSMutableArray alloc] init];
	NSArray* rows = [input componentsSeparatedByString:@"\n"];
	rows = [rows subarrayWithRange:NSMakeRange(0, [rows count] - 1)];
	NSLog(@"rows count = %lu", [rows count]);
	for(NSString* row in rows) {
		NSArray* posStr = [row componentsSeparatedByString:@","];
		Day083DPoint* point = [[Day083DPoint alloc]
							   initWithX:[[posStr objectAtIndex:0] integerValue]
															WithY:[[posStr objectAtIndex:1] integerValue]
															WithZ:[[posStr objectAtIndex:2] integerValue]];
		[positions addObject:point];
	}
	NSLog(@"positions count = %lu", [positions count]);
	
}

- (void) createPairs
{
	pairs = [[NSMutableArray alloc] init];
	for (int p = 0; p < [positions count] - 1; p++) {
		Day083DPoint* p1 = [positions objectAtIndex:p];
		for (int d = p + 1; d < [positions count]; d++) {
			Day083DPoint* p2 = [positions objectAtIndex:d];
			Day08_3DPair *pair = [[Day08_3DPair alloc] initWithPoint1:p1 Point2:p2];
			[pairs addObject:pair];
		}
	}
	NSLog(@"pairs count = %lu", [pairs count]);
//	NSLog(@"example pair: 250000th, p1: %@, p2: %@, dist: %lu",
//		  [[pairs objectAtIndex:250000] point1],
//		  [[pairs objectAtIndex:250000] point2],
//		  [[pairs objectAtIndex:250000] dist]);
	[pairs sortUsingComparator:^NSComparisonResult(Day08_3DPair* _Nonnull pair1, Day08_3DPair* _Nonnull pair2) {
		if ([pair1 dist] < [pair2 dist])
			return NSOrderedAscending;
		else if ([pair1 dist] > [pair2 dist])
			return NSOrderedDescending;
		return NSOrderedSame;
	}];
//	for (Day08_3DPair *pair in [pairs subarrayWithRange:NSMakeRange(0, 10)]) {
//		NSLog(@"%@", pair);
//	}
//	pairs = [[pairs subarrayWithRange:NSMakeRange(0, 1000)] mutableCopy];
}

- (void)createCircuits
{
	circuits = [[NSMutableArray alloc] initWithCapacity:1000];
	for (int i = 0; i < [positions count]; i++) {
		[circuits addObject:[[NSMutableArray alloc] init]];
	}
	
	for (Day08_3DPair *pair in [pairs subarrayWithRange:NSMakeRange(0, 1000)]) {
		NSUInteger index1 = [positions indexOfObject:[pair point1]];
		NSUInteger index2 = [positions indexOfObject:[pair point2]];
//		NSLog(@"index: %lu, pair's point1 %@, position: %@", index, [pair point1], [positions objectAtIndex:index]);
		[[circuits objectAtIndex:index1] addObject:[NSNumber numberWithUnsignedInteger:index2]];
		[[circuits objectAtIndex:index2] addObject:[NSNumber numberWithUnsignedInteger:index1]];
	}
}

- (void)depthFirstSearch
{
	visitedPoints = [[NSMutableSet alloc] init];
	subCircuitsSizes = [[NSMutableArray alloc] init];
	for (NSUInteger u = 0; u < [circuits count]; u++) {
		if (![visitedPoints containsObject:[NSNumber numberWithUnsignedInteger:u]]) {
			NSUInteger subCircuitIndex = [subCircuitsSizes count];
			[subCircuitsSizes addObject:[NSNumber numberWithUnsignedInteger:1]];
			[self dfsVisit:u subCircuit:subCircuitIndex];
		}
	}
}

- (void)dfsVisit:(NSUInteger)u subCircuit:(NSUInteger)ind
{
	[visitedPoints addObject:[NSNumber numberWithUnsignedInteger:u]];
	for (NSNumber *v in [circuits objectAtIndex:u]) {
		if (![visitedPoints containsObject:v]) {
			NSUInteger size = [[subCircuitsSizes objectAtIndex:ind] unsignedIntegerValue];
			size++;
			[subCircuitsSizes replaceObjectAtIndex:ind withObject:[NSNumber numberWithUnsignedInteger:size]];
			[self dfsVisit:[v unsignedIntegerValue] subCircuit:ind];
		}
	}
}

- (void)depthFirstSearchWithNodeSets
{
	visitedPoints = [[NSMutableSet alloc] init];
	subCircuitsSizes = [[NSMutableArray alloc] init];
	nodeSets = [[NSMutableArray alloc] init];
	
	for (NSUInteger u = 0; u < [circuits count]; u++) {
		if (![visitedPoints containsObject:[NSNumber numberWithUnsignedInteger:u]]) {
			NSUInteger subCircuitIndex = [subCircuitsSizes count];
			[nodeSets addObject:[[NSMutableSet alloc] init]];
			[subCircuitsSizes addObject:[NSNumber numberWithUnsignedInteger:1]];
			[self dfsVisitWithNodeSets:u subCircuit:subCircuitIndex];
		}
	}
}

- (void)dfsVisitWithNodeSets:(NSUInteger)u subCircuit:(NSUInteger)ind
{
	[visitedPoints addObject:[NSNumber numberWithUnsignedInteger:u]];
	[[nodeSets objectAtIndex:ind] addObject:[NSNumber numberWithUnsignedInteger:u]];
	for (NSNumber *v in [circuits objectAtIndex:u]) {
		if (![visitedPoints containsObject:v]) {
			NSUInteger size = [[subCircuitsSizes objectAtIndex:ind] unsignedIntegerValue];
			size++;
			[subCircuitsSizes replaceObjectAtIndex:ind withObject:[NSNumber numberWithUnsignedInteger:size]];
			[self dfsVisitWithNodeSets:[v unsignedIntegerValue] subCircuit:ind];
		}
	}
}

- (void)solve
{
	[self createPairs];
	[self createCircuits];
	[self depthFirstSearch];
	NSLog(@"subCircuits count: %lu", [subCircuitsSizes count]);
	[subCircuitsSizes sortUsingComparator:^NSComparisonResult(NSNumber*  _Nonnull obj1, NSNumber*  _Nonnull obj2) {
		if ([obj1 unsignedIntegerValue] > [obj2 unsignedIntegerValue])
			return NSOrderedAscending;
		else if ([obj1 unsignedIntegerValue] < [obj2 unsignedIntegerValue])
			return NSOrderedDescending;
		return NSOrderedSame;
	}];
	NSLog(@"Top 3 circuits: ");
	NSUInteger result = 1;
	for (NSNumber *n in [subCircuitsSizes subarrayWithRange:NSMakeRange(0, 3)]) {
		NSLog(@"%@", n);
		result *= [n unsignedIntegerValue];
	}
	NSLog(@"Result = %lu", result);
	NSLog(@"pairs count = %lu", [pairs count]);
	NSLog(@"subCircuits count = %lu", [subCircuitsSizes count]);
	NSUInteger nodesCnt = 0;
	for (NSNumber *n in subCircuitsSizes) {
//		NSLog(@"%@", n);
		nodesCnt += [n unsignedIntegerValue];
	}
	NSLog(@"nodes %lu", nodesCnt);
}

- (void)continueCreateCircuits
{
	int addPairCnt = 0;
	for (Day08_3DPair *pair in [pairs subarrayWithRange:NSMakeRange(1000, [pairs count] - 1000)]) {
		NSUInteger index1 = [positions indexOfObject:[pair point1]];
		NSUInteger index2 = [positions indexOfObject:[pair point2]];
//		NSLog(@"index: %lu, pair's point1 %@, position: %@", index, [pair point1], [positions objectAtIndex:index]);
		[[circuits objectAtIndex:index1] addObject:[NSNumber numberWithUnsignedInteger:index2]];
		[[circuits objectAtIndex:index2] addObject:[NSNumber numberWithUnsignedInteger:index1]];
		addPairCnt++;
		[self depthFirstSearch];
		if([subCircuitsSizes count] == 1) {
			NSLog(@"----- Star 2 -------");
			NSLog(@"Added %i additional pairs.", addPairCnt);
			NSLog(@"Answer = %lu", [[pair point1] x] * [[pair point2] x]);
			break;
		} else if ([subCircuitsSizes count] == 2) {
			
			NSLog(@"----- Star 2 -------");
			[self depthFirstSearchWithNodeSets];
			NSLog(@"NodeSets count = %lu", [nodeSets count]);
			for (int s = 0; s < [nodeSets count]; s++) {
				NSLog(@"NodeSet %i has %lu nodes.", s, [[nodeSets objectAtIndex:s] count]);
			}
			NSLog(@"Added %i additional pairs.", addPairCnt);
			NSLog(@"Two subgraphs found. Searching for interconnecting node...");
			NSUInteger lonePointIndex = [[[nodeSets objectAtIndex:1]anyObject] unsignedIntegerValue];
			NSLog(@"lonePointIndex = %lu", lonePointIndex);
			Day083DPoint* lonePoint = [positions objectAtIndex:lonePointIndex];
			NSLog(@"lonePoint: %@", lonePoint);
			for (Day08_3DPair *pair in [pairs subarrayWithRange:NSMakeRange(999+addPairCnt, [pairs count] - 1000 - addPairCnt)]) {
				if ([[pair point1] isEqual:lonePoint] || [[pair point2] isEqual:lonePoint]) {
					NSLog(@"Pair: %@", pair);
					NSLog(@"Answer = %lu", [[pair point1] x] * [[pair point2] x]);
					break;
				}
			}
//			NSLog(@"Answer = %lu", [[pair point1] x] * [[pair point2] x]);
			break;
		} else {
			NSLog(@"%i pair connected: subCircuits count = %lu",addPairCnt, [subCircuitsSizes count]);
		}
	}
	NSLog(@"subCircuits count = %lu", [subCircuitsSizes count]);
	NSUInteger nodesCnt = 0;
	for (NSNumber *n in subCircuitsSizes) {
//		NSLog(@"%@", n);
		nodesCnt += [n unsignedIntegerValue];
	}
	NSLog(@"nodes %lu", nodesCnt);
}

@end
