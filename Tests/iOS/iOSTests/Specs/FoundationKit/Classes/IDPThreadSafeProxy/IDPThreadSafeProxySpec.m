//
//  IDPThreadSafeProxy.m
//  iOS
//
//  Created by Oleksa Korin on 9/3/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPThreadSafeProxy.h"

#import "FoundationKit.h"

#import "IDPBlockAsyncRaiseIterativeMatcher.h"
#import "IDPSpecSetup.h"

SPEC_BEGIN(IDPMixinStackSpec)

registerMatchers(@"IDP");
registerMatchers(@"KW");

describe(@"IDPMixinStack", ^{
    __block IDPMixinStack *stack = nil;
    
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
