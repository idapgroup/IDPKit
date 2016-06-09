//
//  IDPModelSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/7/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPTestModel.h"
#import "IDPModelProxy.h"

#import "IDPObjCRuntime.h"

SPEC_BEGIN(IDPModelSpec)

describe(@"IDPModel", ^{
    context(@"when created with proxyClass = IDPModelProxy", ^{
        let(model, ^{ return [IDPTestModel new]; });
        let(target, ^{ return [model target]; });
        
        it(@"should be wrapped in IDPModelProxy", ^{
            [[model should] beMemberOfClass:[IDPModelProxy class]];
        });
        
        it(@"should contain IDPTestModel as target", ^{
            [[[model target] should] beMemberOfClass:[IDPTestModel class]];
        });
        
        context(@"-proxyClass", ^{
            it(@"should return IDPModelProxy", ^{
                [[theValue(IDPClassIsEqualToClass([target proxyClass], [IDPModelProxy class])) should] beTrue];
            });
        });
        
        context(@"-defaultQueue", ^{
            let(queue, ^id{
                return [target defaultQueue];
            });
            
            it(@"should be serial", ^{
                [[theValue([queue maxConcurrentOperationCount]) should] equal:@(1)];
            });
            
            it(@"should be utility QOS", ^{
                [[theValue([queue qualityOfService]) should] equal:@(NSQualityOfServiceUtility)];
            });
        });
        
        context(@"-executeOperation:", ^{
            it(@"should start the operation in background thread", ^{
                __block NSThread *currentThread = nil;
                
                NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                    currentThread = [NSThread currentThread];
                }];
                
                [[operation shouldEventually] receive:@selector(start)];
                [[currentThread shouldNotEventually] equal:[NSThread currentThread]];
                [[currentThread shouldNotEventually] equal:[NSThread mainThread]];
                
                [model executeOperation:operation];
            });
        });
        
        context(@"block execution method", ^{
            id block = ^(IDPModel *model) { };
            
            context(@"-executeBlock:", ^{
                it(@"should return NSBlockOperation", ^{
                    id operation = [model executeBlock:block];
                    
                    [[operation should] beKindOfClass:[NSBlockOperation class]];
                });
                
                it(@"should evaluate block with target parameter", ^{
                    id callback = theBlockProxy(block);
                    [[callback shouldEventually] beEvaluatedWithArguments:target];
                    
                    [model executeBlock:callback];
                });
            });
            
            context(@"-executeSyncBlock:", ^{
                it(@"should evaluate block with target parameter", ^{
                    id callback = theBlockProxy(block);
                    [[callback should] beEvaluatedWithArguments:target];
                    
                    [model executeSyncBlock:callback];
                });
            });
        });
    });
    
    context(@"when created with proxyClass = nil", ^{
        let(model, ^id{
            id model = [IDPTestModel alloc];
            [model stub:@selector(proxyClass) andReturn:nil];

            return [model init];
        });
        
        it(@"should be of IDPTestModel class", ^{
            [[model should] beMemberOfClass:[IDPTestModel class]];
        });
    });
});

SPEC_END
