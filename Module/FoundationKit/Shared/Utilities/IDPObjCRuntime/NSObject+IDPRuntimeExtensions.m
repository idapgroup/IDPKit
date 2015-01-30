//
//  NSObject+IDPRuntimeExtensions.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSObject+IDPRuntimeExtensions.h"

#import <objc/runtime.h>

#import "IDPObjCRuntime.h"

@implementation NSObject (IDPRuntimeExtensions)

+ (Class)KVOClass {
    NSString *className = IDPKVOClassNameWithClass(self);
    
    return NSClassFromString(className);
}

- (Class)isa {
    return object_getClass(self);
}

- (Class)KVOClass {
    return [[self class] KVOClass];
}

@end
