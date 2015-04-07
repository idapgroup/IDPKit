//
//  IDPEnumerationThreadSafeProxySpec.m
//  iOS
//
//  Created by Oleksa Korin on 4/7/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPEnumerationThreadSafeProxy.h"

#import "FoundationKit.h"

#import "IDPBlockAsyncRaiseIterativeMatcher.h"
#import "IDPSpecSetup.h"

SPEC_BEGIN(IDPEnumerationThreadSafeProxySpec)

registerMatchers(@"IDP");
registerMatchers(@"KW");

#if IDPMultithreadedSpecTestEnabled == 1

static const NSUInteger taskCount = IDPMultithreadedSpecIterationCount;

__block id objects = nil;
__block id proxy = nil;
__block id object = nil;

describe(@"NSMutableArray", ^{
    beforeEach(^{
        objects = [NSMutableArray new];
        for (NSUInteger index = 0; index < 10; index++) {
            [objects addObject:[NSObject new]];
        }
    });
    
    afterEach(^{
        objects = nil;
    });
    
    context(@"when used unsafely", ^{
        context(@"when using from different threads", ^{
            it(@"it should raise", ^{
                [[theBlock(^{
                    [objects addObject:[NSObject new]];
                    
                    object = [objects randomObject];
                    if (object) {
                        [objects containsObject:object];
                        [objects removeObject:object];
                    }
                    
                    [objects count];
                }) should] raiseWithIterationCount:taskCount];
            });
        });
        
        context(@"when enumerating", ^{
            it(@"it should be owned by enumerator", ^{
                __weak id weakObjects = objects;
                
                NSEnumerator *enumerator = [objects objectEnumerator];
                
                objects = nil;
                
                [[weakObjects shouldNot] beNil];
                
                while ([enumerator nextObject]) {}
            });
        });
    });
    
    context(@"when used with IDPEnumerationThreadSafe", ^{
        beforeAll(^{
            proxy = [IDPEnumerationThreadSafeProxy proxyWithTarget:objects];
        });
        
        afterAll(^{
            proxy = nil;
        });
        
        context(@"when using from different threads", ^{
            it(@"it shouldn't raise", ^{
                [[theBlock(^{
                    [proxy addObject:[NSObject new]];
                    
                    object = [proxy randomObject];
                    if (object) {
                        [proxy containsObject:object];
                        [proxy removeObject:object];
                    }
                    
                    [proxy count];
                    
                    NSEnumerator *enumerator = [proxy objectEnumerator];
                    while ((object = [enumerator nextObject])) {
                        [object description];
                    }
                }) shouldNot] raiseWithIterationCount:taskCount];
            });
        });
    });
});

//describe(@"IDPThreadSafeProxy", ^{
//    context(@"when shadowing IDPThreadUnsafeObject", ^{
//        beforeEach(^{
//            object = [IDPThreadSafeProxy proxyWithTarget:[IDPThreadUnsafeObject new]];
//        });
//        
//        afterEach(^{
//            object = nil;
//        });
//        
//        context(@"when performing operations simultaneously", ^{
//            it(@"it shouldn't raise", ^{
//                [[theBlock(^{
//                    object.value = arc4random();
//                    object.object = [NSObject new];
//                }) shouldNot] raiseWithIterationCount:taskCount];
//            });
//        });
//    });
//});

#endif // IDPMultithreadedSpecTestEnabled == 1

SPEC_END
