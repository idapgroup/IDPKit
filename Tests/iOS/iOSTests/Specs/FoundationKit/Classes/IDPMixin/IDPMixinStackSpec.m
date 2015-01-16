//
//  IDPMixinStack.m
//  iOS
//
//  Created by Oleksa Korin on 16/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPMixinStack.h"

#import "FoundationKit.h"


SPEC_BEGIN(IDPMixinStackSpec)

describe(@"IDPMixinStack", ^{
    __block IDPMixinStack *stack = nil;
    
    context(@"when empty", ^{
        beforeAll(^{
            stack = [IDPMixinStack new];
        });

        it(@"its count should be 0", ^{
            [[stack should] haveCountOf:0];
        });
    });
    
    context(@"when adding object", ^{
        __block NSObject *object = nil;
        
        beforeAll(^{
            stack = [IDPMixinStack new];
            object = [NSObject new];
            
            [stack addObject:object];
        });
        
        it(@"its count should be 1", ^{
            [[stack should] haveCountOf:1];
        });
        
        it(@"it should contain that object", ^{
            [[[stack.mixins firstObject] should] equal:object];
        });
        
        context(@"after adding another object", ^{
            beforeAll(^{
                [stack addObject:[NSObject new]];
            });
            
            context(@"after readding object at index 0", ^{
                beforeAll(^{
                    object = stack.mixins[0];
                    [stack addObject:object];
                });
                
                it(@"its count should be 2", ^{
                    [[stack should] haveCountOf:2];
                });
                
                it(@"it should move object at index 0 to the last index", ^{
                    [[[stack.mixins lastObject] should] equal:object];
                });
            });
        });
    });
    
    context(@"when working in multithreaded environment", ^{
        const NSUInteger taskCount = 100;

        beforeAll(^{
            stack = [IDPMixinStack new];
        });
        
        
        context(@"when performing operations simultaneously", ^{
            it(@"it shouldn't raise", ^{
                dispatch_group_t group = dispatch_group_create();
                
                void (^test)(void (^)(void)) = ^void ((void (^operation)(void))) {
                    @autoreleasepool {
                        operation = [operation copy];
                        dispatch_group_async(group, IDPDispatchGetQueue(IDPDispatchQueueBackground), ^{
                            @autoreleasepool {
                                [[expectFutureValue(theBlock(operation)) shouldNotEventually] raise];
                            }
                        });
                    }
                };
                
                for (int i = 0; i < taskCount; ++i) {
                    [stack addObject:[NSObject new]];
                }
                
                for (int i = 0; i < taskCount; ++i) {
                    @autoreleasepool {
                        test(^{[stack addObject:[NSObject new]];});
                        
                        test(^{
                            NSObject *object = [stack.mixins randomObject];
                            if (object) {
                                [stack addObject:object];
                            }
                        });
                        
                        test(^{
                            NSObject *object = [stack.mixins randomObject];
                            if (object) {
                                [stack containsObject:object];
                            }
                        });
                        
                        test(^{
                            NSObject *object = [stack.mixins randomObject];
                            if (object) {
                                [stack removeObject:object];
                            }
                        });
                        
                        test(^{[stack count];});
                    }
                }
                
                dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
            });
        });
    });
});

SPEC_END
