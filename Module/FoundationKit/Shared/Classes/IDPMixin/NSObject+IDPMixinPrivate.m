//
//  NSObject+IDPMixinPrivate.m
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSObject+IDPMixinPrivate.h"

#import <objc/runtime.h>

static NSString * const kIDPMixinStackProperty      = @"kIDPMixinStackProperty";
static NSString * const kIDPMixinIMPProperty        = @"kIDPMixinIMPProperty";

@implementation NSObject (IDPMixinPrivate)

+ (IDPMixinIMP *)mixinIMP {
    Class theClass = [NSObject class];
    
    @synchronized (theClass) {
        return objc_getAssociatedObject(theClass,
                                        (__bridge const void *)(kIDPMixinIMPProperty));
    }
}

+ (void)setMixinIMP:(IDPMixinIMP *)object {
    Class theClass = [NSObject class];
    
    @synchronized (theClass) {
        objc_setAssociatedObject(theClass,
                                 (__bridge const void *)(kIDPMixinIMPProperty),
                                 object,
                                 OBJC_ASSOCIATION_RETAIN);
    }
}

- (IDPMixinStack *)stack {
    return objc_getAssociatedObject(self,
                                    (__bridge const void *)(kIDPMixinStackProperty));
}

- (void)setStack:(IDPMixinStack *)stack {
    objc_setAssociatedObject(self,
                             (__bridge const void *)(kIDPMixinStackProperty),
                             stack,
                             OBJC_ASSOCIATION_RETAIN);
}

@end
