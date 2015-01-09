//
//  IDPMixinContext.m
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPOCContext.h"

#import "IDPOCStack.h"
#import "IDPOCImplementation.h"

#import <objc/runtime.h>

#import "NSObject+IDPOCExtensionsPrivate.h"
#import "NSObject+IDPExtensions.h"

static id IDPForwardingTargetForSelectorMixinMethod(id _self, SEL __cmd, SEL aSelector) {
    NSObject *object = (NSObject *)_self;
    IDPOCStack *stack = object.stack;
    IDPOCImplementation *implementation = [NSObject implementation];
    
    __block id result = nil;
    
    [stack enumerateObjectsWithOptions:NSEnumerationReverse
                            usingBlock:^(id<NSObject> iter, NSUInteger idx, BOOL *stop) {
                                if ([iter respondsToSelector:aSelector]) {
                                    result = iter;
                                    *stop = YES;
                                }
                            }];
    
    if (result) {
        return result;
    }
    
    IMP originalImplementation = implementation.forwardingInvocationForSelectorIMP;

    return ((id (*)(id, SEL, SEL))(originalImplementation))(_self, __cmd, aSelector);
}

static BOOL IDPRespondsToSelectorMixinMethod(id _self, SEL __cmd, SEL aSelector) {
    NSObject *object = (NSObject *)_self;
    IDPOCStack *stack = object.stack;
    IDPOCImplementation *implementation = [NSObject implementation];
    
    __block BOOL result = NO;
    
    [stack enumerateObjectsWithOptions:NSEnumerationReverse
                            usingBlock:^(id<NSObject> iter, NSUInteger idx, BOOL *stop) {
                                if ([iter respondsToSelector:aSelector]) {
                                    result = YES;
                                    *stop = YES;
                                }
                            }];
    
    if (result) {
        return result;
    }
    
    IMP originalImplementation = implementation.respondsToSelectorIMP;
    
    return ((BOOL (*)(id, SEL, SEL))(originalImplementation))(_self, __cmd, aSelector);
}

@interface IDPOCContext ()
@property (nonatomic, retain) id<NSObject>      target;
@property (nonatomic, retain) id<NSObject>      mixin;

- (void)setupNSObjectImplementation;

// returns the previous implementation
- (IMP)setImplementation:(IMP)implementation
             forSelector:(SEL)selector
                 inClass:(Class)theClass;

- (void)invoke;

@end

@implementation IDPOCContext

#pragma mark -
#pragma mark Class Methods

+ (void)extendObject:(id<NSObject>)target
          withObject:(id<NSObject>)mixin
{
    IDPOCContext *context = [self object];
    context.target = target;
    context.mixin = mixin;
    
    [context invoke];
}

+ (void)relinquishExtensionOfObject:(id<NSObject>)target
                         withObject:(id<NSObject>)mixin
{
    NSObject *object = target;
    [object.stack removeObject:mixin];
}

+ (BOOL)isObject:(id<NSObject>)target extendedByObject:(id<NSObject>)mixin {
    NSObject *object = target;
    return [object.stack containsObject:mixin];
}

+ (NSArray *)extendingObjectsOfObject:(id<NSObject>)target {
    NSObject *object = target;
    return [NSArray arrayWithArray:object.stack];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.target = nil;
    self.mixin = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)invoke {
    NSObject *target = self.target;
    
    if (nil == target.stack) {
        target.stack = [IDPOCStack object];
        [self setupNSObjectImplementation];
    }
    
    [target.stack addObject:self.mixin];
}

#pragma mark -
#pragma mark Private

- (void)setupNSObjectImplementation {
    Class theClass = [NSObject class];
    if (nil == [theClass implementation]) {
        IDPOCImplementation *implementation = [IDPOCImplementation object];
        
        IMP imp = [self setImplementation:(IMP)IDPForwardingTargetForSelectorMixinMethod
                              forSelector:@selector(forwardingTargetForSelector:)
                                  inClass:theClass];
        implementation.forwardingInvocationForSelectorIMP = imp;
        
        imp = [self setImplementation:(IMP)IDPRespondsToSelectorMixinMethod
                          forSelector:@selector(respondsToSelector:)
                              inClass:theClass];
        implementation.respondsToSelectorIMP = imp;
        
        [theClass setImplementation:implementation];
    }
}

- (IMP)setImplementation:(IMP)implementation
              forSelector:(SEL)selector
                  inClass:(Class)theClass
{
    IMP previousIMP = [theClass instanceMethodForSelector:selector];
    
    Method method = class_getInstanceMethod(theClass, selector);
    class_replaceMethod(theClass,
                        selector,
                        implementation,
                        method_getTypeEncoding(method));
    
    return previousIMP;
}

@end
