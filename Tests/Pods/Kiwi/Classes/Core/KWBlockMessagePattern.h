//
//  KWMessagePattern.h
//  Kiwi
//
//  Created by Oleksa 'trimm' Korin on 4/19/16.
//  Copyright © 2016 Allen Ding. All rights reserved.
//

#import "KWMessagePattern.h"

// Block signature doesn't have a selector as the second hidden argument, so block message pattern has selector = NULL

@interface KWBlockMessagePattern : KWMessagePattern

- (id)initWithArgumentFilters:(NSArray *)anArray;
- (id)initWithFirstArgumentFilter:(id)firstArgumentFilter argumentList:(va_list)argumentList;

+ (id)messagePattern;
+ (id)messagePatternWithArgumentFilters:(NSArray *)anArray;
+ (id)messagePatternWithFirstArgumentFilter:(id)firstArgumentFilter argumentList:(va_list)argumentList;

@end
