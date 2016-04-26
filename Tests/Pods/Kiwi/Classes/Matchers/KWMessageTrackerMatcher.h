//
//  KWMessageTrackerMatcher.h
//  Kiwi
//
//  Created by Oleksa 'trimm' Korin on 4/20/16.
//  Copyright © 2016 Allen Ding. All rights reserved.
//

#import "KWMatcher.h"

#import "KWCountType.h"

@class KWMessageTracker;
@class KWMessagePattern;

@interface KWMessageTrackerMatcher : KWMatcher

#pragma mark - Properties

@property (nonatomic, readonly) KWMessageTracker *messageTracker;
@property (nonatomic, assign) BOOL willEvaluateMultipleTimes;
@property (nonatomic, assign) BOOL willEvaluateAgainstNegativeExpectation;

@end

@interface KWMessageTrackerMatcher (KWKWMessageTrackerMatcherPrivate)

// method is used for inheritance and should not be called directly
- (void)setMessageTrackerWithMessagePattern:(KWMessagePattern *)aMessagePattern
                                  countType:(KWCountType)aCountType
                                      count:(NSUInteger)aCount;

@end
