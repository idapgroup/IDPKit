//
//  KWBlockMessagePattern.m
//  Kiwi
//
//  Created by Oleksa 'trimm' Korin on 4/19/16.
//  Copyright © 2016 Allen Ding. All rights reserved.
//

#import "KWBlockMessagePattern.h"

#import "KWFormatter.h"

@implementation KWBlockMessagePattern

#pragma mark - Initializing

- (id)init {
    return [super initWithSelector:NULL];
}

- (id)initWithArgumentFilters:(NSArray *)anArray {
    return [super initWithSelector:NULL argumentFilters:anArray];
}

- (id)initWithFirstArgumentFilter:(id)firstArgumentFilter argumentList:(va_list)argumentList {
    return [super initWithSelector:NULL firstArgumentFilter:firstArgumentFilter argumentList:argumentList];
}

+ (id)messagePattern {
    return [super messagePatternWithSelector:NULL];
}

+ (id)messagePatternWithArgumentFilters:(NSArray *)anArray {
    return [super messagePatternWithSelector:NULL argumentFilters:anArray];
}

+ (id)messagePatternWithFirstArgumentFilter:(id)firstArgumentFilter argumentList:(va_list)argumentList {
    return [super messagePatternWithSelector:NULL firstArgumentFilter:firstArgumentFilter argumentList:argumentList];
}

#pragma mark - Properties

- (SEL)selector {
    return NULL;
}

#pragma mark - Matching Invocations

- (BOOL)matchesInvocation:(NSInvocation *)anInvocation {
    // additional variable created to suppress NONNULL warning in NSInvocation selector
    SEL selector = NULL;
    anInvocation.selector = selector;
    
    return [super matchesInvocation:anInvocation];
}

#pragma mark - Comparing Message Patterns

- (NSUInteger)hash {
    return [self.argumentFilters hash];
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[KWBlockMessagePattern class]])
        return NO;
    
    return [self isEqualToMessagePattern:object];
}

#pragma mark - Retrieving String Representations


- (NSString *)stringValue {
    NSMutableString *description = [NSMutableString stringWithString:@"block call( "];
    NSArray *argumentFilters = self.argumentFilters;
    
    NSUInteger count = [argumentFilters count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        NSString *argumentFilterString = [KWFormatter formatObject:(self.argumentFilters)[i]];
        [description appendFormat:@"%@, ", argumentFilterString];
    }
    
    [description appendFormat:@")"];
    
    return description;
}

#pragma mark - Debugging

- (NSString *)description {
    return [NSString stringWithFormat:@"argumentFilters: %@", self.argumentFilters];
}

@end
