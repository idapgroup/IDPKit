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

#import "IDPThreadUnsafeObject.h"

SPEC_BEGIN(IDPThreadSafeProxySpec)

registerMatchers(@"IDP");
registerMatchers(@"KW");

#if IDPMultithreadedSpecTestEnabled == 1

__block IDPThreadUnsafeObject *object = nil;
static const NSUInteger taskCount = IDPMultithreadedSpecIterationCount;

describe(@"IDPThreadUnsafeObject", ^{
    beforeEach(^{
        object = [IDPThreadUnsafeObject new];
    });
    
    afterEach(^{
        object = nil;
    });
    
    context(@"when mutating from different threads", ^{
        it(@"it should raise", ^{
            [[theBlock(^{
                object.value = arc4random();
                object.object = [NSObject new];
            }) should] raiseWithIterationCount:taskCount];
        });
    });
});

describe(@"IDPThreadSafeProxy", ^{
    context(@"when shadowing IDPThreadUnsafeObject", ^{
        context(@"when performing operations simultaneously", ^{
            it(@"it shouldn't raise", ^{
                [[theBlock(^{
                    object.value = arc4random();
                    object.object = [NSObject new];
                }) shouldNot] raiseWithIterationCount:taskCount];
            });
        });
    });
});

#endif // IDPMultithreadedSpecTestEnabled == 1

SPEC_END
