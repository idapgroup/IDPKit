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
    context(@"after being created", ^{
        __block IDPBackgroundOperation *operation = nil;
        beforeAll(^{
            operation = [IDPBackgroundOperation new];
        });
        
        it(@"shouldn't be nil", ^{
            [[operation shouldNot] beNil];
        });
        
        it(@"shoul be asynchronous", ^{
            [[theValue([operation isAsynchronous]) should] beYes];
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
        
        context(@"after was started", ^{
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
        
        context(@"after was started", ^{
            it(@"should eventually receive @selector(complete)", ^{
                [[operation shouldNot] receive:@selector(complete)];
                [[operation shouldEventually] receive:@selector(complete)];
                
                [operation start];
            });
        });
    });
    
    context(@"after being created", ^{
        __block IDPBackgroundOperation *operation = nil;
        __block NSOperationQueue *queue = nil;
        
        beforeAll(^{
            operation = [IDPBackgroundOperation new];
            queue = [NSOperationQueue new];
        });
        
        context(@"after being added to queue", ^{
            it(@"should eventually receive @selector(main)", ^{
                [[operation shouldNot] receive:@selector(main)];
                [[operation shouldEventually] receive:@selector(main)];
                
                [queue addOperation:operation];
            });
        });
    });
    
    context(@"after being created", ^{
        __block IDPBackgroundOperation *operation = nil;
        beforeAll(^{
            operation = [IDPBackgroundOperation new];
        });
        
        context(@"after was added to suspended queue", ^{
            __block NSOperationQueue *queue = nil;
            
            beforeAll(^{
                queue = [NSOperationQueue new];
                queue.suspended = YES;
                [queue addOperation:operation];
            });
            
            it(@"shouldn't receive @selector(main)", ^{
                [[operation shouldNot] receive:@selector(main)];
                [[operation shouldNotEventually] receive:@selector(main)];
            });
            
            it(@"queue operations should have count of 1", ^{
                [[queue.operations should] haveCountOf:1];
            });
        });
    });
    
    context(@"after being created", ^{
        __block IDPBackgroundOperation *operation = nil;
        beforeAll(^{
            operation = [IDPBackgroundOperation new];
        });
        
        context(@"after was added to suspended queue", ^{
            __block NSOperationQueue *queue = nil;
            beforeAll(^{
                queue = [NSOperationQueue new];
                queue.suspended = YES;
                [queue addOperation:operation];
            });
            
            context(@"after queue was canceled", ^{
                it(@"should receive cancel selector", ^{
                    [[operation should] receive:@selector(cancel)];
                    [queue cancelAllOperations];
                });
            });
        });
    });
    
    context(@"after another operation being created", ^{
        __block IDPBackgroundOperation *operation = nil;
        beforeAll(^{
            operation = [IDPBackgroundOperation new];
        });
        
        context(@"after operation being added to suspended queue", ^{
            __block NSOperationQueue *queue = nil;
            beforeAll(^{
                queue = [NSOperationQueue new];
                queue.suspended = YES;
                [queue addOperation:operation];
            });
            
            context(@"after queue cancellation", ^{
                beforeAll(^{
                    [queue cancelAllOperations];
                });
                
                context(@"after queue was resumed", ^{
                    it(@"should not receive @selector(main)", ^{
                        [[operation shouldNot] receive:@selector(main)];
                        [[operation shouldNotEventually] receive:@selector(main)];
                        
                        queue.suspended = NO;
                    });
                });
            });
        });
    });
});

SPEC_END
