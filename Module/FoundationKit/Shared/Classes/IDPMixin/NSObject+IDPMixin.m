//
//  NSObject+IDPMixin.m
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSObject+IDPMixin.h"

#import "IDPMixinContext.h"

@implementation NSObject (IDPMixin)

- (void)extendWithObject:(id<NSObject>)object {
    [IDPMixinContext extendObject:self withObject:object];
}

- (void)relinquishExtensionWithObject:(id<NSObject>)mixin {
    [IDPMixinContext relinquishExtensionOfObject:self withObject:mixin];
}

- (BOOL)isExtendedByObject:(id<NSObject>)mixin {
    return [IDPMixinContext isObject:self extendedByObject:mixin];
}

- (NSArray *)extendingObjects {
    return [IDPMixinContext extendingObjectsOfObject:self];
}

@end
