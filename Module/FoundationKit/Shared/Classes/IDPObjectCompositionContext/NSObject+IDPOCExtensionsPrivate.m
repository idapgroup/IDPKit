//
//  NSObject+IDPOCExtensionsPrivate.m
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSObject+IDPOCExtensionsPrivate.h"

#import <objc/runtime.h>

static NSString * const kIDPOCStackProperty             = @"kIDPOCStackProperty";
static NSString * const kIDPOCImplementationProperty    = @"kIDPOCImplementationProperty";

@implementation NSObject (IDPOCExtensionsPrivate)

+ (void)setImplementation:(IDPOCImplementation *)object {
    objc_setAssociatedObject(self,
                             (__bridge const void *)(kIDPOCImplementationProperty),
                             object,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (IDPOCImplementation *)implementation {
    return objc_getAssociatedObject(self,
                                    (__bridge const void *)(kIDPOCImplementationProperty));
}

- (IDPOCStack *)stack {
    return objc_getAssociatedObject(self,
                                    (__bridge const void *)(kIDPOCStackProperty));
}

- (void)setStack:(IDPOCStack *)stack {
    objc_setAssociatedObject(self,
                             (__bridge const void *)(kIDPOCStackProperty),
                             stack,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
