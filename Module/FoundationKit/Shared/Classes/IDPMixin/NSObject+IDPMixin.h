//
//  NSObject+IDPMixin.h
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

@interface NSObject (IDPMixin)
@property (nonatomic, readonly)     NSArray     *mixins;

// convenience methods wrapping around the
// IDPMixinContext

- (void)extendWithObject:(id<NSObject>)object;
- (void)relinquishExtensionWithObject:(id<NSObject>)mixin;
- (BOOL)isExtendedByObject:(id<NSObject>)mixin;

@end
