//
//  NSObject+IDPOCExtensions.h
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPOCContext.h"

@interface NSObject (IDPOCExtensions)

// convenience methods wrapping around the
// IDPOCContext

- (void)extendWithObject:(id<NSObject>)object;
- (void)relinquishExtensionWithObject:(id<NSObject>)mixin;
- (BOOL)isExtendedByObject:(id<NSObject>)mixin;
- (NSArray *)extendingObjects;

@end
