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
                    id object = [NSObject new];
                    [objects addObject:object];
                    
                    if (object && [objects containsObject:object]) {
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
                
                [enumerator nextObject];
            });
            
            context(@"after mutation", ^{
                it(@"it should raise", ^{
                    [[theBlock(^{
                        NSEnumerator *enumerator = [objects objectEnumerator];
                        [enumerator nextObject];
                        
                        [objects addObject:[NSObject new]];
                        
                        [enumerator nextObject];
                    }) should] raise];
                });
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
                    id object = [NSObject new];
                    [proxy addObject:object];
                    
                    if (object && [proxy containsObject:object]) {
                        [proxy removeObject:object];
                    }
                    
                    [proxy count];
                    
                    NSEnumerator *enumerator = [proxy objectEnumerator];
                    while ([enumerator nextObject]) {}
                }) shouldNot] raiseWithIterationCount:taskCount];
            });
        });
        
        context(@"when enumerating and after mutation", ^{
            context(@"after mutation", ^{
                it(@"it shouldn't raise", ^{
                    [[theBlock(^{
                        NSEnumerator *enumerator = [proxy objectEnumerator];
                        [enumerator nextObject];
                        
                        [objects addObject:[NSObject new]];
                        
                        [enumerator nextObject];
                    }) shouldNot] raise];
                });
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
