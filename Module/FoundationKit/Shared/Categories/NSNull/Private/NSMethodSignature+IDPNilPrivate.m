//
//  NSMethodSignature+IDPNilPrivate.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/13/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSMethodSignature+IDPNilPrivate.h"

#import "NSObject+IDPRuntime.h"

static const NSString * kIDPMethodSignatureNilForwarded    = @"kIDPMethodSignatureNilForwarded";

@implementation NSMethodSignature (IDPNilPrivate)

@dynamic nilForwarded;

#pragma mark -
#pragma mark Accessors

- (void)setNilForwarded:(BOOL)nilForwarded {
    [self       setValue:@(nilForwarded)
          forPropertyKey:kIDPMethodSignatureNilForwarded
       associationPolicy:IDPPropertyNonatomicStrong];
}

- (BOOL)isNilForwarded {
    return [[self valueForPropertyKey:kIDPMethodSignatureNilForwarded] boolValue];
}

@end
