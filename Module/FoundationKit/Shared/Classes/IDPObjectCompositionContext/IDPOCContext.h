//
//  IDPMixinContext.h
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

// Object composition has the lwoest priority
// and is overridden by everything
// If you want to override the class behaviour,
// instead of extending it, use categories

// if there are multiple comosition objects
// responding to the same selector, composition
// is handled by the one, who was the latest

// be warned, that the mechanism is not inheritance
// safe and you are the one responsible for controlling
// what happens with the compositions. A general rule of
// thumb is to compose the object with of different
// inheritance hierarchies

@interface IDPOCContext : NSObject

+ (void)extendObject:(id<NSObject>)target withObject:(id<NSObject>)mixin;
+ (void)relinquishExtensionOfObject:(id<NSObject>)target withObject:(id<NSObject>)mixin;
+ (BOOL)isObject:(id<NSObject>)target extendedByObject:(id<NSObject>)mixin;
+ (NSArray *)extendingObjectsOfObject:(id<NSObject>)targer;

@end