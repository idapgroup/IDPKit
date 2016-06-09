//
//  NSObject+IDPExtensions.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/9/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSObject+IDPExtensions.h"

#import "NSArray+IDPExtensions.h"

@implementation NSObject (IDPExtensions)

+ (instancetype)object {
    return [self new];
}

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    return [NSArray arrayWithCount:count factoryBlock:^{ return [self new]; }];
}

@end
