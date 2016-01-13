//
//  NSObject+IDPRuntime.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/13/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSObject+IDPRuntime.h"

@implementation NSObject (IDPRuntime)

+ (void)setBlock:(IDPBlockWithIMP)block forSelector:(SEL)selector {
    IMP implementation = [self instanceMethodForSelector:selector];
    
    IMP blockIMP = imp_implementationWithBlock(block(implementation));
    
    Method method = class_getInstanceMethod(self, selector);
    class_replaceMethod(self,
                        selector,
                        blockIMP,
                        method_getTypeEncoding(method));
}

- (void)setValue:(id)value forPropertyKey:(const NSString *)key associationPolicy:(IDPPropertyPolicy)policy {
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, (objc_AssociationPolicy)policy);
}

- (id)valueForPropertyKey:(const NSString *)key {
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

@end
