//
//  NSObject+IDPMixinSpec.m
//  iOS
//
//  Created by Oleksa Korin on 16/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "FoundationKit.h"

#import "IDPSpecSetup.h"

SPEC_BEGIN(NSObject_IDPMixin)

describe(@"NSObject+IDPMixin", ^{
    context(@"when not extended", ^{
        __block NSObject *target = nil;
        
        beforeAll(^{
            target = [NSObject new];
        });
        
        it(@"it shouldn't have mixins", ^{
            [[target.mixins should] beNil];
        });
    });
    
    context(@"after extending NSObject with NSString @\"response\" mixin", ^{
        __block NSString *target = nil;
        __block NSString *mixin = nil;
        NSString * const response = @"response";
        
        beforeAll(^{
            mixin = [NSString stringWithString:response];
            target = (NSString *)[NSObject new];
            
            [target extendWithObject:mixin];
        });
        
        it(@"it should have mixins array", ^{
            [[target.mixins shouldNot] beNil];
        });
        
        it(@"its mixin count should be 1", ^{
            [[target.mixins should] haveCountOf:1];
        });
        
        it(@"it should be extended by mixin", ^{
            [[theValue([target isExtendedByObject:mixin]) should] beYes];
        });
        
        it(@"it should respond to length", ^{
            [[target should] respondToSelector:@selector(length)];
        });
        
        it(@"it should be equal to response string", ^{
            [[theValue([target isEqualToString:response]) should] beYes];
        });
        
        context(@"after relinqushing extension with NSString mixin", ^{
            beforeAll(^{
                [target relinquishExtensionWithObject:mixin];
            });
            
            it(@"its mixin count should be 0", ^{
                [[target.mixins should] haveCountOf:0];
            });
            
            it(@"it shouldn't be extended by mixin", ^{
                [[theValue([target isExtendedByObject:mixin]) should] beNo];
            });

            it(@"it shouldn't respond to length", ^{
                [[target shouldNot] respondToSelector:@selector(length)];
            });
        });
    });
    
    context(@"after extending NSObject with NSMutableArray then NSArray containing @\"response\"", ^{
        __block NSMutableArray *target = nil;
        __block NSArray *array = nil;
        __block NSMutableArray *mutableArray = nil;
        NSString * const response = @"response";
        
        beforeAll(^{
            target = (NSMutableArray *)[NSObject new];
            
            array = [NSArray arrayWithObject:response];
            mutableArray = [NSMutableArray new];
            
            [target extendWithObject:mutableArray];
            [target extendWithObject:array];
        });
        
        it(@"it should respond to count", ^{
            [[theValue([target respondsToSelector:@selector(count)]) should] beYes];
        });
        
        it(@"its count should be 1", ^{
            [[target should] haveCountOf:1];
        });
        
        it(@"its first object should be @\"response\"", ^{
            [[[target firstObject] should] equal:response];
        });
        
        context(@"after adding object to target", ^{
            NSObject *object = [NSObject new];
            
            beforeAll(^{
                [target addObject:object];
            });
            
            it(@"its count should be 1", ^{
                [[target should] haveCountOf:1];
            });
            
            it(@"its first object should be @\"response\"", ^{
                [[[target firstObject] should] equal:response];
            });
            
            context(@"after putting NSMutableArray mixin on top of the mixin chain", ^{
                beforeAll(^{
                    [target extendWithObject:mutableArray];
                });
                
                it(@"its count should be 1", ^{
                    [[target should] haveCountOf:1];
                });
                
                it(@"its first object should be object", ^{
                    [[[target firstObject] should] equal:object];
                });
            });
        });
        

    });
    
#if IDPMultithreadedSpecTestEnabled == 1
    context(@"when working in multithreaded environment", ^{
        const NSUInteger taskCount = IDPMultithreadedSpecIterationCount;
        const NSUInteger timeout = IDPMultithreadedWaitTime;
        __block NSObject *target = nil;
        
        beforeAll(^{
            target = [NSObject new];
        });
        
        
        context(@"after performing operations simultaneously", ^{
            it(@"it shouldn't raise", ^{
                dispatch_group_t group = dispatch_group_create();
                
                void (^test)(void (^)(void)) = ^void ((void (^operation)(void))) {
                    @autoreleasepool {
                        operation = [operation copy];
                        dispatch_group_async(group, IDPDispatchGetQueue(IDPDispatchQueueBackground), ^{
                            @autoreleasepool {
                                [[expectFutureValue(theBlock(operation)) shouldNotEventuallyBeforeTimingOutAfter(timeout)] raise];
                            }
                        });
                    }
                };
                
                for (int i = 0; i < taskCount; ++i) {
                    [target extendWithObject:[NSString new]];
                }
                
                for (int i = 0; i < taskCount; ++i) {
                    @autoreleasepool {
                        test(^{[target extendWithObject:[NSString new]];});
                        
                        test(^{
                            NSObject *object = [target.mixins randomObject];
                            if (object) {
                                [target extendWithObject:[NSString new]];
                            }
                        });
                        
                        test(^{
                            NSObject *object = [target.mixins randomObject];
                            if (object) {
                                [target isExtendedByObject:object];
                            }
                        });
                        
                        test(^{
                            NSObject *object = [target.mixins randomObject];
                            if (object) {
                                [target relinquishExtensionWithObject:object];
                            }
                        });
                    }
                }
                
                dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
            });
        });
    });
#endif
});

SPEC_END