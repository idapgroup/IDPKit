//
//  KWBeEvaluatedMatcher.m
//  Kiwi
//
//  Created by Oleksa 'trimm' Korin on 4/20/16.
//  Copyright © 2016 Allen Ding. All rights reserved.
//

#import "KWBeEvaluatedMatcher.h"

#import "KWBlockMessagePattern.h"
#import "KWCountType.h"
#import "KWMessageTracker.h"
#import "KWWorkarounds.h"
#import "KWProxyBlock.h"

@implementation KWBeEvaluatedMatcher

#pragma mark - Getting Matcher Strings

+ (NSArray *)matcherStrings {
    return @[@"beEvaluated",
             @"beEvaluatedWithCount",
             @"beEvaluatedWithCountAtLeast:",
             @"beEvaluatedWithCountAtMost:",
             @"beEvaluatedWithArguments:",
             @"beEvaluatedWithCount:arguments:",
             @"beEvaluatedWithCountAtLeast:arguments:",
             @"beEvaluatedWithCountAtMost:arguments:"];
}

#pragma mark - Configuring Matchers

- (void)beEvaluated {
    [self beEvaluatedWithUnspecifiedCountOfMessagePattern:[KWBlockMessagePattern messagePattern]];
}

- (void)beEvaluatedWithCount:(NSUInteger)aCount {
    [self beEvaluatedWithCountType:KWCountTypeExact count:aCount];
}

- (void)beEvaluatedWithCountAtLeast:(NSUInteger)aCount {
    [self beEvaluatedWithCountType:KWCountTypeAtLeast count:aCount];
}

- (void)beEvaluatedWithCountAtMost:(NSUInteger)aCount {
    [self beEvaluatedWithCountType:KWCountTypeAtMost count:aCount];
}

- (void)beEvaluatedWithCountType:(KWCountType)aCountType count:(NSUInteger)aCount {
    [self receiveMessagePattern:[KWBlockMessagePattern messagePattern]
                      countType:aCountType
                          count:aCount];
}

- (void)beEvaluatedWithUnspecifiedCountOfMessagePattern:(KWBlockMessagePattern *)messagePattern {
    KWCountType countType = self.willEvaluateAgainstNegativeExpectation ? KWCountTypeAtLeast : KWCountTypeExact;
    
    [self beEvaluatedWithCountType:countType count:1];
}

#define KWStartVAListWithVariableName(listName) \
    va_list listName; \
    va_start(listName, firstArgument);

- (void)beEvaluatedWithArguments:(id)firstArgument, ... {
    KWStartVAListWithVariableName(argumentList);

    KWBlockMessagePattern *messagePattern = [KWBlockMessagePattern messagePatternWithFirstArgumentFilter:firstArgument
                                                                                            argumentList:argumentList];

    [self beEvaluatedWithUnspecifiedCountOfMessagePattern:messagePattern];
}

#define KWReceiveVAListMessagePatternWithCountType(aCountType) \
    do { \
        KWStartVAListWithVariableName(argumentList); \
        id messagePattern = [KWBlockMessagePattern messagePatternWithFirstArgumentFilter:firstArgument argumentList:argumentList]; \
        [self receiveMessagePattern:messagePattern countType:aCountType count:aCount]; \
    } while(0)

- (void)beEvaluatedWithCount:(NSUInteger)aCount arguments:(id)firstArgument, ... {
    KWReceiveVAListMessagePatternWithCountType(KWCountTypeExact);
}

- (void)beEvaluatedWithCountAtLeast:(NSUInteger)aCount arguments:(id)firstArgument, ... {
    KWReceiveVAListMessagePatternWithCountType(KWCountTypeAtLeast);
}

- (void)beEvaluatedWithCountAtMost:(NSUInteger)aCount arguments:(id)firstArgument, ... {
    KWReceiveVAListMessagePatternWithCountType(KWCountTypeAtMost);
}

#undef KWReceiveVAListMessagePatternWithCountType
#undef KWArgumentList

#pragma mark - Message Pattern Receiving

- (void)receiveMessagePattern:(KWBlockMessagePattern *)aMessagePattern countType:(KWCountType)aCountType count:(NSUInteger)aCount {
#if KW_TARGET_HAS_INVOCATION_EXCEPTION_BUG
    @try {
#endif // #if KW_TARGET_HAS_INVOCATION_EXCEPTION_BUG

    [self setMessageTrackerWithMessagePattern:aMessagePattern countType:aCountType count:aCount];
        
#if KW_TARGET_HAS_INVOCATION_EXCEPTION_BUG
    } @catch(NSException *exception) {
        KWSetExceptionFromAcrossInvocationBoundary(exception);
    }
#endif // #if KW_TARGET_HAS_INVOCATION_EXCEPTION_BUG
}

#pragma mark - Matching

- (BOOL)shouldBeEvaluatedAtEndOfExample {
    return YES;
}

- (BOOL)evaluate {
    if (![self.subject isKindOfClass:[KWProxyBlock class]])
        [NSException raise:@"KWMatcherException" format:@"subject must be a KWProxyBlock"];

    return [super evaluate];
}


@end
