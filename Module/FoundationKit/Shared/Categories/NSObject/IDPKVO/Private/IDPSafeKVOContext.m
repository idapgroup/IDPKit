//
//  IDPSafeKVOContext.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPSafeKVOContext.h"

#import <objc/runtime.h>

NSString * const kIDPSafeKVOSubclassPostfix =   @"_IDPSafeKVO";

@interface IDPSafeKVOContext ()
@property (nonatomic, strong)   NSObject    *object;

- (void)invoke;

- (Class)subclass;
- (BOOL)isKVOSubclass;
- (BOOL)isSafeSubclass;

- (Class)createSafeSubclass;

@end

@implementation IDPSafeKVOContext

#pragma mark -
#pragma mark Class Methods

+ (void)performSafeSubclassingWithObject:(NSObject *)object {
    IDPSafeKVOContext *context = [IDPSafeKVOContext new];
    context.object = object;
    
    [context invoke];
}

#pragma mark -
#pragma mark Private

- (void)invoke {
    if (![self isKVOSubclass] || [self isSafeSubclass]) {
        return;
    }
    
    Class subclass = [self subclass];
    if (Nil == subclass) {
        subclass = [self createSafeSubclass];
    }
    
    object_setClass(self.object, subclass);
}

- (BOOL)isKVOSubclass {
    NSObject *object = self.object;
    
    return [object class] != class_getSuperclass(object_getClass(object));
}

- (BOOL)isSafeSubclass {
    return [self subclass] == object_getClass(self.object);
}

- (Class)subclass {
    NSString *className = [NSString stringWithFormat:@"%@%@",
                           NSStringFromClass(object_getClass(self.object)),
                           kIDPSafeKVOSubclassPostfix];
    
    return NSClassFromString(className);
}

- (Class)createSafeSubclass {
    return Nil;
}

@end
