//
//  IDPBlockAsyncRaiseIterativeMatcher.h
//  iOS
//
//  Created by Oleksa Korin on 19/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "KWBlockRaiseMatcher.h"

@interface IDPBlockAsyncRaiseIterativeMatcher : KWBlockRaiseMatcher

- (void)raiseWithIterationCount:(NSUInteger)count;

- (void)raiseWithName:(NSString *)aName
       iterationCount:(NSUInteger)count;

- (void)raiseWithReason:(NSString *)aReason
         iterationCount:(NSUInteger)count;

- (void)raiseWithName:(NSString *)aName
               reason:(NSString *)aReason
       iterationCount:(NSUInteger)count;

@end
