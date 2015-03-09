//
//  IDPKVOObject.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPKVOObject.h"
#import "IDPObjCRuntime.h"

#import "IDPTestObject.h"

#import "NSObject+IDPKVOPrivate.h"

SPEC_BEGIN(IDPKVOObjectSpec)

describe(@"IDPKVOObject", ^{
    context(@"when initializing with improper parameters", ^{
        context(@"using -init", ^{
            it(@"it should return nil", ^{
                [[[[IDPKVOObject alloc] init] should] beNil];
            });
        });
        
        context(@"using -initWithObject:keyPaths:handler:options:", ^{
            it(@"it should return nil", ^{
                id object = [[IDPKVOObject alloc] initWithObject:nil
                                                        keyPaths:nil
                                                         options:0
                                                         handler:nil];

                [[object should] beNil];
            });
        });
    });
    
    context(@"when observing -value of IDPTestObject object with -value = 1", ^{
        __block IDPTestObject *object = nil;
        __block IDPKVOObject *observer = nil;
        __block IDPKVONotification *notification = nil;
        
        beforeAll(^{
            object = [IDPTestObject new];
            object.value = 1;
            
            observer = [IDPKVOObject objectWithObject:object
                                             keyPaths:@[IDPStringFromSEL(value)]
                                              handler:^(IDPKVONotification *input) {
                                                  notification = input;
                                              }];
            
            observer.observing = YES;
        });
        
        it(@"it should be valid", ^{
            [[theValue(observer.valid) should] beYes];
        });
        
        it(@"its observed objects KVObjectsSet should contain 1 object", ^{
            [[theValue([object.KVOObjectsSet count]) should] equal:theValue(1)];
        });
        
        it(@"it should be contained in KVObjectsSet of observer", ^{
            [[[object.KVOObjectsSet anyObject] should] equal:observer];
        });

        context(@"when setting -value=2", ^{
            beforeAll(^{
                notification = nil;
                object.value = 2;
            });
            
            it(@"it should generate IDPKVONotification object", ^{
                [[notification should] beNonNil];
            });
            
            context(@"IDPKVONotification object", ^{
                it(@"its old value should equal to 1", ^{
                    NSObject *value = notification.oldValue;
                    [[value should] equal:theValue(1)];
                });
                
                it(@"its value should equal to 2", ^{
                    NSObject *value = notification.value;
                    [[value should] equal:theValue(2)];
                });
                
                it(@"its keypath should equal @\"value\"", ^{
                    [[notification.keyPath should] equal:IDPStringFromSEL(value)];
                });
                
                it(@"its changeType should equal NSKeyValueChangeSetting", ^{
                    [[theValue(notification.changeType) should] equal:theValue(NSKeyValueChangeSetting)];
                });
            });
        });
        
        context(@"after observing was disabled", ^{
            beforeAll(^{
                notification = nil;
                observer.observing = NO;
                
                object.value = 3;
            });
            
            it(@"it shouldn't generate notifications", ^{
                [[notification should] beNil];
            });
            
            context(@"after observing was enabled", ^{
                beforeAll(^{
                    notification = nil;
                    observer.observing = YES;
                    
                    object.value = 1;
                });
                
                it(@"it should generate notifications", ^{
                    [[notification should] beNonNil];
                });
            });
        });
        
        context(@"after observed object was deallocated", ^{
            __block __weak IDPTestObject *weakObject = nil;
            
            beforeAll(^{
                weakObject = object;
                object = nil;
            });
            
            it(@"it should safely remove observation", ^{
                [[theValue(observer.observing) should] beNo];
            });
            
            it(@"it shouldn't be valid", ^{
                [[theValue(observer.valid) should] beNo];
            });
            
            context(@"when the object is invalid and oberving is set to YES", ^{
                beforeAll(^{
                    observer.observing = YES;
                });
                
                it(@"it shouldn't be invalid ", ^{
                    [[theValue(observer.valid) should] beNo];
                });
                
                it(@"its observing value should be NO", ^{
                    [[theValue(observer.observing) should] beNo];
                });
            });
        });
    });
});

SPEC_END
