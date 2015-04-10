//
//  NSObject+IDPRuntime.m
//  iOS
//
//  Created by Oleksa Korin on 4/9/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSObject+IDPRuntime.h"

#import <objc/runtime.h>

#import "IDPObjCRuntime.h"

@implementation NSObject (IDPRuntime)

+ (NSSet *)subclasses {
    return IDPSubclassesOfClassSet(self);
}

- (Class)isa {
    return object_getClass(self);
}

@end
