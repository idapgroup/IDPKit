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
                             kIDPOCImplementationProperty,
                             object,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (IDPOCImplementation *)implementation {
    return objc_getAssociatedObject(self,
                                    kIDPOCImplementationProperty);
}

- (IDPOCStack *)stack {
    return objc_getAssociatedObject(self,
                                    kIDPOCStackProperty);
}

- (void)setStack:(IDPOCStack *)stack {
    objc_setAssociatedObject(self,
                             kIDPOCStackProperty,
                             stack,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
