//
//  IDPMixinContext.m
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMixinContext.h"

#import "IDPMixinStack.h"
#import "IDPMixinIMP.h"

#import <objc/runtime.h>

#import "NSObject+IDPMixin.h"
#import "NSObject+IDPMixinPrivate.h"


static id IDPForwardingTargetForSelectorMixinMethod(id _self, SEL __cmd, SEL aSelector) {
    NSObject *object = (NSObject *)_self;
    
    IDPMixinIMP *implementation = [NSObject mixinIMP];
    NSArray *stack = object.mixins;
    
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

    IDPMixinIMP *implementation = [NSObject mixinIMP];
    NSArray *stack = object.mixins;
    
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

@interface IDPMixinContext ()
@property (nonatomic, strong) id<NSObject>      target;
@property (nonatomic, strong) id<NSObject>      mixin;

- (void)setupNSObjectImplementation;

// returns the previous implementation
- (IMP)setImplementation:(IMP)implementation
             forSelector:(SEL)selector
                 inClass:(Class)theClass;

- (void)invoke;

@end

@implementation IDPMixinContext

#pragma mark -
#pragma mark Class Methods

+ (void)extendObject:(id<NSObject>)target
          withObject:(id<NSObject>)mixin
{
    IDPMixinContext *context = [self new];
    context.target = target;
    context.mixin = mixin;
    
    [context invoke];
}

#pragma mark -
#pragma mark Private

- (void)invoke {
    NSObject *target = self.target;
    
    if (nil == target.stack) {
        target.stack = [IDPMixinStack new];
        [self setupNSObjectImplementation];
    }
    
    [target.stack addObject:self.mixin];
}

- (void)setupNSObjectImplementation {
    Class theClass = [NSObject class];
    @synchronized (theClass) {
        if (nil == [theClass mixinIMP]) {
            IDPMixinIMP *implementation = [IDPMixinIMP new];
            
            IMP imp = [self setImplementation:(IMP)IDPForwardingTargetForSelectorMixinMethod
                                  forSelector:@selector(forwardingTargetForSelector:)
                                      inClass:theClass];
            implementation.forwardingInvocationForSelectorIMP = imp;
            
            imp = [self setImplementation:(IMP)IDPRespondsToSelectorMixinMethod
                              forSelector:@selector(respondsToSelector:)
                                  inClass:theClass];
            implementation.respondsToSelectorIMP = imp;
            
            [theClass setMixinIMP:implementation];
        }
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
