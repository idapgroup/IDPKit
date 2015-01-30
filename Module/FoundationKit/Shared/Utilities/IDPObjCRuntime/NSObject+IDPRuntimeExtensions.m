//
//  NSObject+IDPRuntimeExtensions.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSObject+IDPRuntimeExtensions.h"

#import <objc/runtime.h>

@implementation NSObject (IDPRuntimeExtensions)

- (Class)isa {
    return object_getClass(self);
}

@end
