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

#import "IDPBlockAsyncRaiseIterativeMatcher.h"
#import "IDPSpecSetup.h"

SPEC_BEGIN(IDPMixinStackSpec)

registerMatchers(@"IDP");
registerMatchers(@"KW");

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
    
    context(@"when adding target object", ^{
        __block NSObject *target = nil;
        
        beforeAll(^{
            stack = [IDPMixinStack new];
            target = [NSObject new];
            
            [stack addObject:target];
        });
        
        it(@"its count should be 1", ^{
            [[stack should] haveCountOf:1];
        });
        
        it(@"it should contain target", ^{
            [[[stack.mixins firstObject] should] equal:target];
        });
        
        context(@"after adding another object", ^{
            beforeAll(^{
                [stack addObject:[NSObject new]];
            });
            
            context(@"after readding target", ^{
                beforeAll(^{
                    [stack addObject:target];
                });
                
                it(@"its count should be 2", ^{
                    [[stack should] haveCountOf:2];
                });
                
                it(@"it should move object target to the last index", ^{
                    [[[stack.mixins lastObject] should] equal:target];
                });
                
                context(@"after removing object at index 0", ^{
                    beforeAll(^{
                        [stack removeObject:[stack.mixins firstObject]];
                    });
                    
                    it(@"its count should be 1", ^{
                        [[stack should] haveCountOf:1];
                    });
                    
                    it(@"it should contain the target", ^{
                        [[[stack.mixins lastObject] should] equal:target];
                    });
                });
            });
        });
    });
    
#if IDPMultithreadedSpecTestEnabled == 1
    context(@"when working in multithreaded environment", ^{
        const NSUInteger taskCount = IDPMultithreadedSpecIterationCount;

        beforeAll(^{
            stack = [IDPMixinStack new];
            
            for (int i = 0; i < 10; ++i) {
                [stack addObject:[NSObject new]];
            }
        });
        
        
        context(@"when performing operations simultaneously", ^{
            it(@"it shouldn't raise", ^{
                [[theBlock(^{
                    [stack addObject:[NSObject new]];

                    NSObject *object = [stack.mixins randomObject];
                    if (object) {
                        [stack addObject:object];
                    }
                    
                    object = [stack.mixins randomObject];
                    if (object) {
                        [stack containsObject:object];
                    }
                    
                    object = [stack.mixins randomObject];
                    if (object) {
                        [stack removeObject:object];
                    }
                    
                    [stack count];
                }) shouldNot] raiseWithIterationCount:taskCount];
            });
        });
    });
#endif
});

SPEC_END
