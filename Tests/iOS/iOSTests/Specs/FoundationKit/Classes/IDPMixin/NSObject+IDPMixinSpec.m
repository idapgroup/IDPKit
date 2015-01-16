//
//  NSObject+IDPMixinSpec.m
//  iOS
//
//  Created by Oleksa Korin on 16/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "FoundationKit.h"

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
    
    context(@"when extending NSObject with NSString @\"response\" mixin", ^{
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
        
        it(@"it should contain mixin", ^{
            [[theValue([target isExtendedByObject:mixin]) should] beYes];
        });
        
        it(@"it should respond to length", ^{
            [target respondsToSelector:@selector(length)];
        });
        
        it(@"it should be equal to response string", ^{
            [[theValue([target isEqualToString:response]) should] beYes];
        });
        
//        context(@"after adding another object", ^{
//            beforeAll(^{
//                [stack addObject:[NSObject new]];
//            });
//            
//            context(@"after readding object at index 0", ^{
//                beforeAll(^{
//                    object = stack.mixins[0];
//                    [stack addObject:object];
//                });
//                
//                it(@"its count should be 2", ^{
//                    [[stack should] haveCountOf:2];
//                });
//                
//                it(@"it should move object at index 0 to the last index", ^{
//                    [[[stack.mixins lastObject] should] equal:object];
//                });
//            });
//        });
    });
    
//    context(@"when working in multithreaded environment", ^{
//        const NSUInteger taskCount = 100;
//        
//        beforeAll(^{
//            stack = [IDPMixinStack new];
//        });
//        
//        
//        context(@"when performing operations simultaneously", ^{
//            it(@"it shouldn't raise", ^{
//                dispatch_group_t group = dispatch_group_create();
//                
//                void (^test)(void (^)(void)) = ^void ((void (^operation)(void))) {
//                    @autoreleasepool {
//                        operation = [operation copy];
//                        dispatch_group_async(group, IDPDispatchGetQueue(IDPDispatchQueueBackground), ^{
//                            @autoreleasepool {
//                                [[expectFutureValue(theBlock(operation)) shouldNotEventually] raise];
//                            }
//                        });
//                    }
//                };
//                
//                for (int i = 0; i < taskCount; ++i) {
//                    [stack addObject:[NSObject new]];
//                }
//                
//                for (int i = 0; i < taskCount; ++i) {
//                    @autoreleasepool {
//                        test(^{[stack addObject:[NSObject new]];});
//                        
//                        test(^{
//                            NSObject *object = [stack.mixins randomObject];
//                            if (object) {
//                                [stack addObject:object];
//                            }
//                        });
//                        
//                        test(^{
//                            NSObject *object = [stack.mixins randomObject];
//                            if (object) {
//                                [stack containsObject:object];
//                            }
//                        });
//                        
//                        test(^{
//                            NSObject *object = [stack.mixins randomObject];
//                            if (object) {
//                                [stack removeObject:object];
//                            }
//                        });
//                        
//                        test(^{[stack count];});
//                    }
//                }
//                
//                dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//            });
//        });
//    });
});

SPEC_END