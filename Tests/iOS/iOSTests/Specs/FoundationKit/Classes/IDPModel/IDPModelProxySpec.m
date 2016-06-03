//
//  IDPModelProxySpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/3/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPTestModel.h"
#import "IDPModelProxy.h"

typedef id(^IDPMethodStubBlock)(NSArray *parameters);

SPEC_BEGIN(IDPModelProxySpec)

describe(@"IDPModelProxy", ^{
    __block IDPTestModel *model = nil;
    __block IDPTestModel *proxy = nil;
    
    beforeEach(^{
        model = [IDPTestModel new];
        
        proxy = [IDPModelProxy proxyWithTarget:model];
    });
    
    context(@"when sending messages", ^{
        it(@"should return nil for method returning object", ^{
            [[proxy.object should] beNil];
        });
        
        it(@"should return 0 for method returning NSUInteger", ^{
            [[theValue(proxy.value) should] beZero];
        });
        
        it(@"should return CGRectZero for method returning CGRect", ^{
            [[theValue(proxy.frame) should] equal:theValue(CGRectZero)];
        });
        
        it(@"should not raise, when void method implemented in model is called", ^{
            [[theBlock(^{ [proxy setObject:[NSObject new]]; }) shouldNot] raise];
        });
        
        it(@"should raise, when method not implemented in model is called", ^{
            [[theBlock(^{ [(id)proxy array]; }) should] raise];
        });
        
        it(@"should forward NSInvocationOperation to model, which updates the model after execution", ^{
            NSObject *object = [NSObject new];
            
            [model stub:@selector(executeOperation:) withBlock:^id (NSArray *array) {
                id operation = array[0];
                [[operation should] beMemberOfClass:[NSInvocationOperation class]];
                
                [operation start];
                
                return nil;
            }];
            
            [proxy setObject:object];
            
            [[proxy.object should] equal:object];
        });
    });
});

SPEC_END

