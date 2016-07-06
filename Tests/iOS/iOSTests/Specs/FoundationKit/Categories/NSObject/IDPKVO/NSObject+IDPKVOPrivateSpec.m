//
//  IDPSafeKVOContextSpec.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import <objc/runtime.h>

#import "IDPSelector.h"
#import "IDPTestObject.h"
#import "IDPKVOObserver.h"

#import "NSObject+IDPKVO.h"
#import "NSObject+IDPKVOPrivate.h"
#import "NSObject+IDPRuntime.h"

SPEC_BEGIN(NSObject_IDPKVOPrivateSpec)

describe(@"Apple KVO", ^{
    context(@"IDPKVONameOfClass", ^{
        it(@"it should return @\"NSKVONotifying_NSObject\" for NSObject", ^{
            [[IDPKVONameOfClass([NSObject class]) should] equal:@"NSKVONotifying_NSObject"];
        });
    });
    
    context(@"when observing the object", ^{
        __block IDPTestObject *object = nil;
        __block IDPKVOObserver *observer = nil;
        
        NSString *className = @"NSKVONotifying_IDPTestObject";
        
        beforeAll(^{
            object = [IDPTestObject new];
            object.value = 1;
            object.object = [NSObject new];
            
            observer = [IDPKVOObserver new];
            
            [object addObserver:observer
                     forKeyPath:IDPStringFromSEL(value)
                        options:NSKeyValueObservingOptionNew
                        context:NULL];
        });

        it(@"its +KVOClass should return NSKVONotifying_IDPTestObject", ^{
            [[[[object class] KVOClass] should] equal:NSClassFromString(className)];
        });
        
        it(@"its -KVOClass should return NSKVONotifying_IDPTestObject", ^{
            [[[object KVOClass] should] equal:NSClassFromString(className)];
        });
        
        it(@"its -class should return IDPTestObject", ^{
            [[[object class] should] equal:[IDPTestObject class]];
        });
        
        it(@"its -isa should equal its KVOClass", ^{
            [[[object isa] should] equal:[object KVOClass]];
        });
        
        it(@"its -isa superclass should be IDPTestObject", ^{
            [[[[object isa] superclass] should] equal:[IDPTestObject class]];
        });
        
        it(@"its -isKVOClassObject should return YES", ^{
            [[theValue([object isKVOClassObject]) should] beYes];
        });
        
        context(@"after adding another observed keypath -object", ^{
            __block Class isa = Nil;
            
            beforeAll(^{
                isa = [object isa];
                
                [object addObserver:observer
                         forKeyPath:IDPStringFromSEL(object)
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
            });
            
            afterAll(^{
                [object removeObserver:observer
                            forKeyPath:IDPStringFromSEL(object)];
            });
            
            it(@"its -class should return IDPTestObject", ^{
                [[[object class] should] equal:[IDPTestObject class]];
            });
            
            it(@"its -isa should be NSKVONotifying_IDPTestObject", ^{
                [[[object isa] should] equal:NSClassFromString(className)];
            });
            
            it(@"its -isa superclass should be IDPTestObject", ^{
                [[[[object isa] superclass] should] equal:[IDPTestObject class]];
            });
            
            it(@"its -isa pointer after adding should equal isa before adding", ^{
                [[theValue([object isa]) should] equal:theValue(isa)];
            });
        });
        
        context(@"after removing all observers", ^{
            beforeAll(^{
                [object removeObserver:observer
                            forKeyPath:IDPStringFromSEL(value)];
            });
            
            it(@"its -isa should equal its -class", ^{
                [[[object isa] should] equal:[object class]];
            });
            
            it(@"its -isa should be IDPTestObject", ^{
                [[[object isa] should] equal:[IDPTestObject class]];
            });
            
            it(@"its KVO class counterpart shouldn't be destroyed", ^{
                Class isa = [object KVOClass];
                [[theValue(isa) shouldNot] equal:theValue(nil)];
            });
            
            it(@"its -isKVOClassObject should return NO", ^{
                [[theValue([object isKVOClassObject]) should] beNo];
            });
        });
    });
});

SPEC_END
