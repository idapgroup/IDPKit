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

SPEC_BEGIN(IDPModelSpec)

describe(@"IDPModel", ^{
    context(@"when created with proxyClass = IDPModelProxy", ^{
        let(model, ^id{ return [IDPTestModel new]; });
        let(target, ^id{ return [model target]; });
        
        it(@"should be wrapped in IDPModelProxy", ^{
            [[model should] beMemberOfClass:[IDPModelProxy class]];
        });
        
        it(@"should contain IDPTestModel as target", ^{
            [[[model target] should] beMemberOfClass:[IDPTestModel class]];
        });
        
        context(@"executeOperation:", ^{
            it(@"should call targets executeOperation:", ^{
                [[target should] receive:@selector(executeOperation:)];
                
                [model executeOperation:[NSBlockOperation blockOperationWithBlock:^{ }]];
            });
            
            it(@"should start the operation in background thread", ^{
                __block NSThread *currentThread = nil;
                
                NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                    currentThread = [NSThread currentThread];
                }];
                
                [[operation shouldEventually] receive:@selector(start)];
                [[currentThread shouldNotEventually] equal:[NSThread currentThread]];
                
                [model executeOperation:operation];
            });
        });
        
        context(@"executeBlock:", ^{
            id block = ^(IDPModel *model) { };
            
            it(@"should return NSBlockOperation", ^{
                id operation = [model executeBlock:block];
                
                [[operation should] beKindOfClass:[NSBlockOperation class]];
            });
            
            it(@"should evaluate block with target parameter", ^{
                id callback = theBlockProxy(block);
                [[callback shouldEventually] beEvaluatedWithArguments:target];
                
                [model executeBlock:callback];
            });
            
            it(@"should call targets executeBlock:", ^{
                [[target should] receive:@selector(executeBlock:)];
                
                [model executeBlock:block];
            });
            
            it(@"should execute block operation using executeOperation:", ^{
                [[target should] receive:@selector(executeOperation:)];
                
                [model executeBlock:block];
            });
        });
    });
    
    context(@"when created with proxyClass = nil", ^{
        it(@"should be of IDPTestModel class", ^{
            id model = [IDPTestModel alloc];
            [model stub:@selector(proxyClass) andReturn:nil];
            model = [model init];
            
            [[model should] beMemberOfClass:[IDPTestModel class]];
        });
    });
});

SPEC_END
