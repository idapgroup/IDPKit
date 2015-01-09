//
//  NSObject+IDPOCExtensions.m
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSObject+IDPOCExtensions.h"

@implementation NSObject (IDPOCExtensions)

- (void)extendWithObject:(id<NSObject>)object {
    [IDPOCContext extendObject:self withObject:object];
}

- (void)relinquishExtensionWithObject:(id<NSObject>)mixin {
    [IDPOCContext relinquishExtensionOfObject:self withObject:mixin];
}

- (BOOL)isExtendedByObject:(id<NSObject>)mixin {
    return [IDPOCContext isObject:self extendedByObject:mixin];
}

- (NSArray *)extendingObjects {
    return [IDPOCContext extendingObjectsOfObject:self];
}

@end
