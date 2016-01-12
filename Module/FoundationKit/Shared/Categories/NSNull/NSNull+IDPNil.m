//
//  NSNull+IDPNil.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/12/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSNull+IDPNil.h"

#import <objc/runtime.h>

typedef NSMethodSignature *(*IDPMethodSignatureForSelectorIMP)(id, SEL, SEL);
typedef id(^IDPBlockWithIMPBlock)(IMP implementation);

@implementation NSNull (IDPNil)

+ (void)load {
//    IMP forwardInvocationIMP = [self instanceMethodForSelector:@selector(forwardInvocation:)];
    [self replaceMethodSignatureForSelector];
    [self replaceForwardInvocation];
}

// TODO: explain what it does
+ (void)replaceMethodSignatureForSelector {
    SEL methodSignatureForSelectorSEL = @selector(methodSignatureForSelector:);
    
    IDPBlockWithIMPBlock block = ^(IMP implementation){
        IDPMethodSignatureForSelectorIMP methodSignatureForSelectorIMP = (IDPMethodSignatureForSelectorIMP)implementation;
        
        return (id)^(NSNull *null, SEL selector) {
            id methodSingature = methodSignatureForSelectorIMP(null, methodSignatureForSelectorSEL, selector);
            if (methodSingature) {
                return methodSingature;
            }
            
            return (id)methodSignatureForSelectorIMP(null, methodSignatureForSelectorSEL, @selector(fakeMethod));
        };
    };
    
    [self setBlock:block forSelector:@selector(methodSignatureForSelector:)];
}

+ (void)replaceForwardInvocation {
    
}

+ (void)setBlock:(IDPBlockWithIMPBlock)block forSelector:(SEL)selector {
    IMP implementation = [self instanceMethodForSelector:selector];;
    
    IMP blockIMP = imp_implementationWithBlock(block(implementation));
    
    Method method = class_getInstanceMethod(self, selector);
    class_replaceMethod(self,
                        selector,
                        blockIMP,
                        method_getTypeEncoding(method));
}

- (void)fakeMethod {

}

@end
