//
//  NSObject+IDPMixin.m
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSObject+IDPMixin.h"

#import "IDPMixinContext.h"
#import "IDPMixinStack.h"

#import "NSObject+IDPMixinPrivate.h"

@implementation NSObject (IDPMixin)

@dynamic mixins;

- (void)extendWithObject:(id<NSObject>)object {
    [IDPMixinContext extendObject:self withObject:object];
}

- (void)relinquishExtensionWithObject:(id<NSObject>)mixin {
    [self.stack removeObject:mixin];
}

- (BOOL)isExtendedByObject:(id<NSObject>)mixin {
    return [self.stack containsObject:mixin];
}

- (NSArray *)mixins {
    return self.stack.mixins;
}

@end
