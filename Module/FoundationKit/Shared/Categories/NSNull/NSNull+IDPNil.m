//
//  NSNull+IDPNil.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/12/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSNull+IDPNil.h"

#import "NSObject+IDPRuntime.h"
#import "NSMethodSignature+IDPNilPrivate.h"

typedef NSMethodSignature *(*IDPMethodSignatureForSelectorIMP)(id, SEL, SEL);
typedef void(*IDPForwardInvocationIMP)(id, SEL, id);

@interface NSNull (IDPNilPrivate)

// Replaces methodSignatureForSelector: imp with imp, that calls original implementation and returns its result,
// if it's non-nil. Otherwise it returns fakeMethod method signature.
+ (void)replaceMethodSignatureForSelector;

// Replaces forwardInvocation: imp with imp, that calls original implementation and returns its result,
// if NSInvocation methodSignature is unrelated to fakeMetohd. Otherwise it executes NSInvocation with target nil.
+ (void)replaceForwardInvocation;

- (void)fakeMethod;

@end

@implementation NSNull (IDPNil)

+ (void)load {
    [self replaceMethodSignatureForSelector];
    [self replaceForwardInvocation];
}

@end

@implementation NSNull (IDPNilPrivate)

+ (void)replaceMethodSignatureForSelector {
    SEL selector = @selector(methodSignatureForSelector:);
    
    IDPBlockWithIMP block = ^(IMP implementation) {
        IDPMethodSignatureForSelectorIMP methodIMP = (IDPMethodSignatureForSelectorIMP)implementation;
        
        return (id)^(NSNull *nullObject, SEL selectorIMPParameter) {
            NSMethodSignature *methodSignature = methodIMP(nullObject, selector, selectorIMPParameter);
            if (methodSignature) {
                return methodSignature;
            }
            
            methodSignature = methodIMP(nullObject, selector, @selector(fakeMethod));
            methodSignature.nilForwarded = YES;
            
            return methodSignature;
        };
    };
    
    [self setBlock:block forSelector:selector];
}

+ (void)replaceForwardInvocation {
    SEL selector = @selector(forwardInvocation:);
    
    IDPBlockWithIMP block = ^(IMP implementation) {
        IDPForwardInvocationIMP methodIMP = (IDPForwardInvocationIMP)implementation;        
        
        return (id)^(NSNull *nullObject, NSInvocation *invocation) {
            if (invocation.methodSignature.nilForwarded) {
                invocation.target = nil;
                [invocation invoke];
            } else {
                methodIMP(nullObject, selector, invocation);
            }
        };
    };
    
    [self setBlock:block forSelector:selector];
}

- (void)fakeMethod {
    
}

@end
