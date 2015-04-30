//
//  IDPBackgroundOperationSpec.m
//  iOS
//
//  Created by Alexander Kradenkov on 4/25/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPBackgroundOperation.h"

SPEC_BEGIN(IDPBackgroundOperationSpec)

describe(@"IDPBackgroundOperation", ^{
    context(@"after operation being created", ^{
        __block IDPBackgroundOperation *operation = nil;
        beforeAll(^{
            operation = [IDPBackgroundOperation new];
        });
        
        it(@"shouldn't be nil", ^{
            [[operation shouldNot] beNil];
        });
        
        it(@"shoul be asynchronous", ^{
            [[theValue(operation.isAsynchronous) should] beYes];
        });
        
        it(@"shouldn't be finished", ^{
            [[theValue(operation.isFinished) shouldNot] beYes];
        });

        it(@"shouldn't be executed", ^{
            [[theValue(operation.isExecuting) shouldNot] beYes];
        });
        
        it(@"should be kind of NSOperation class", ^{
            [[operation should] beKindOfClass:[NSOperation class]];
        });
        
        context(@"while operation being started", ^{
            it(@"should eventually receive @selector(main)", ^{
                [[operation shouldNot] receive:@selector(main)];
                [[operation shouldEventually] receive:@selector(main)];
                [operation start];
            });
        });
    });
    
    context(@"after operation being created", ^{
        __block IDPBackgroundOperation *operation = nil;
        beforeAll(^{
            operation = [IDPBackgroundOperation new];
        });
        
        context(@"while operation being started", ^{
            it(@"should eventually receive @selector(complete)", ^{
                [[operation shouldNot] receive:@selector(complete)];
                [[operation shouldEventually] receive:@selector(complete)];
                [operation start];
            });
        });
    });
    
    context(@"after another operation being created", ^{
        __block IDPBackgroundOperation *operation = nil;
        beforeAll(^{
            operation = [IDPBackgroundOperation new];
        });
        
        context(@"while operation being added to queue", ^{
            __block NSOperationQueue *queue = nil;
            
            beforeAll(^{
                queue = [NSOperationQueue new];
            });
            
            it(@"shouldn't eventually receive @selector(complete)", ^{
                [[operation shouldEventually] receive:@selector(complete)];
                [queue addOperation:operation];
            });
        });
    });
});

SPEC_END