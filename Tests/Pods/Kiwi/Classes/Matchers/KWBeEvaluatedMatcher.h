//
//  KWBeEvaluatedMatcher.h
//  Kiwi
//
//  Created by Oleksa 'trimm' Korin on 4/20/16.
//  Copyright © 2016 Allen Ding. All rights reserved.
//

#import "KWMessageTrackerMatcher.h"

@interface KWBeEvaluatedMatcher : KWMessageTrackerMatcher

- (void)beEvaluated;
- (void)beEvaluatedWithCount:(NSUInteger)aCount;
- (void)beEvaluatedWithCountAtLeast:(NSUInteger)aCount;
- (void)beEvaluatedWithCountAtMost:(NSUInteger)aCount;

- (void)beEvaluatedWithArguments:(id)firstArgument, ...;
- (void)beEvaluatedWithCount:(NSUInteger)aCount arguments:(id)firstArgument, ...;
- (void)beEvaluatedWithCountAtLeast:(NSUInteger)aCount arguments:(id)firstArgument, ...;
- (void)beEvaluatedWithCountAtMost:(NSUInteger)aCount arguments:(id)firstArgument, ...;

@end
