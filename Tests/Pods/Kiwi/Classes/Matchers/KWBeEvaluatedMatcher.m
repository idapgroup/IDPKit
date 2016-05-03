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
             @"beEvaluatedWithCountAtMost:arguments:",
             @"beEvaluatedWithUnspecifiedCountOfMessagePattern:",
             @"beEvaluatedWithMessagePattern:countType:count:"];
}

#pragma mark - Configuring Matchers

- (void)beEvaluated {
    id pattern = [KWBlockMessagePattern messagePatternWithSignature:[self subjectSignature]];
    [self beEvaluatedWithUnspecifiedCountOfMessagePattern:pattern];
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
    id pattern = [KWBlockMessagePattern messagePatternWithSignature:[self subjectSignature]];
    
    [self beEvaluatedWithMessagePattern:pattern countType:aCountType count:aCount];
}

- (void)beEvaluatedWithUnspecifiedCountOfMessagePattern:(KWBlockMessagePattern *)messagePattern {
    KWCountType countType = self.willEvaluateAgainstNegativeExpectation ? KWCountTypeAtLeast : KWCountTypeExact;
    
    [self beEvaluatedWithCountType:countType count:1];
}

#define KWStartVAListWithVariableName(listName) \
    va_list listName; \
    va_start(listName, firstArgument);

- (void)beEvaluatedWithArguments:(id)firstArgument, ... {
    va_list argumentList;
    va_start(argumentList, firstArgument);

    id pattern = [KWBlockMessagePattern messagePatternWithSignature:[self subjectSignature]
                                                firstArgumentFilter:firstArgument
                                                       argumentList:argumentList];

    [self beEvaluatedWithUnspecifiedCountOfMessagePattern:pattern];
}

#define KWReceiveVAListMessagePatternWithCountType(aCountType) \
    do { \
        KWStartVAListWithVariableName(argumentList); \
        id pattern = [KWBlockMessagePattern messagePatternWithSignature:[self subjectSignature] \
                                                    firstArgumentFilter:firstArgument \
                                                           argumentList:argumentList]; \
        [self beEvaluatedWithMessagePattern:pattern countType:aCountType count:aCount]; \
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

- (void)beEvaluatedWithMessagePattern:(KWBlockMessagePattern *)aMessagePattern countType:(KWCountType)aCountType count:(NSUInteger)aCount {
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

- (NSMethodSignature *)subjectSignature {
    return [self.subject methodSignature];
}

@end

@implementation KWMatchVerifier (KWBeEvaluatedMatcherAdditions)

#pragma mark - Verifying

#define KWStartVAListWithVariableName(listName) \
    va_list listName; \
    va_start(listName, firstArgument);

- (void)beEvaluatedWithArguments:(id)firstArgument, ... {
    KWStartVAListWithVariableName(argumentList)
    
    id pattern = [KWBlockMessagePattern messagePatternWithSignature:[self beEvaluated_subjectSignature]
                                                firstArgumentFilter:firstArgument
                                                       argumentList:argumentList];
    
    [(id)self beEvaluatedWithUnspecifiedCountOfMessagePattern:pattern];
}

#define KWReceiveVAListMessagePatternWithCountType(aCountType) \
    do { \
        KWStartVAListWithVariableName(argumentList); \
        id pattern = [KWBlockMessagePattern messagePatternWithSignature:[self beEvaluated_subjectSignature] \
        firstArgumentFilter:firstArgument \
        argumentList:argumentList]; \
        [(id)self beEvaluatedWithMessagePattern:pattern countType:aCountType count:aCount]; \
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

- (NSMethodSignature *)beEvaluated_subjectSignature {
    return [self.subject methodSignature];
}

@end

