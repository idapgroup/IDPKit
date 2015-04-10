//
//  IDPSafeKVOContextSpec.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import <objc/runtime.h>

#import "IDPInheritanceTestObject.h"

#import "NSObject+IDPRuntime.h"

SPEC_BEGIN(NSObject_IDPRuntimeSpec)

describe(@"[NSObject subclasses]", ^{
    context(@"when requesting for subclasses of IDPInheritanceTestObject", ^{
        __block NSSet *subclasses = nil;
        beforeAll(^{
            // call methods, so the classes are loaded
            id object = [[IDPInheritanceTestObject alloc] init];
            object = [[IDPInheritanceTestObjectSubclass alloc] init];
            
            subclasses = [IDPInheritanceTestObject subclasses];
        });
        
        it(@"it should return a set with one element", ^{
            [[subclasses should] haveCountOf:1];
        });
        
        it(@"it should return a set containing IDPThreadUnsafeObject", ^{
            [[subclasses should] contain:[IDPInheritanceTestObjectSubclass class]];
        });
    });
});

SPEC_END
