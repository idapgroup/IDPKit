//
//  IDPObserverSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/3/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPObservableObject.h"
#import "IDPObserver.h"

SPEC_BEGIN(IDPObserverSpec)

describe(@"IDPObserver", ^{
    const NSUInteger state = 150;
    
    __block IDPObservableObject *observableObject = nil;
    __block IDPObserver *observer = nil;
    
    beforeEach(^{
        observableObject = [IDPObservableObject new];
        observer = [[IDPObserver alloc] initWithObservableObject:observableObject];
    });
    
    afterEach(^{
        observableObject = nil;
        observer = nil;
    });
    
    context(@"when created with observing object and observable object as parameter", ^{
        it(@"shouldn't be nil", ^{
            [[observer shouldNot] beNil];
        });
        
        it(@"should contain observable object", ^{
            [[observer.observableObject should] equal:observableObject];
        });
    });
    
    context(@"after being deallocated", ^{
        beforeEach(^{
            observer = nil;
        });
        
        it(@"should be removed from observable object", ^{
            [[observableObject.observers should] haveCountOf:0];
        });
    });
    
    context(@"when setting block for state", ^{
        id block = ^(id observableObject, id info) { [NSObject description]; };
        
        beforeEach(^{
            [observer setBlock:block forState:state];
        });
        
        it(@"should return that block for that state", ^{
            [[[observer blockForState:state] should] equal:block];
        });
        
        context(@"when setting block=nil for state", ^{
            beforeEach(^{
                [observer setBlock:nil forState:state];
            });
            
            it(@"should return nil for state", ^{
                [[[observer blockForState:state] should] beNil];
            });
        });
    });
    
    context(@"when setting block for state using indexed subscript", ^{
        id block = ^(id observableObject, id info) { [NSObject description]; };
        
        beforeEach(^{
            observer[state] = block;
        });
        
        it(@"should return that block for that state", ^{
            [[observer[state] should] equal:block];
        });
        
        context(@"when setting block=nil for state", ^{
            beforeEach(^{
                observer[state] = nil;
            });
            
            it(@"should return nil for state", ^{
                [[observer[state] should] beNil];
            });
        });
    });
    
   
    context(@"when executing block for state", ^{
        id notification = [NSObject new];
        
        __block id sender = nil;
        __block id receivedNotification = nil;
       
        beforeEach(^{
            id callback = ^(id observableObject, id info) {
                sender = observableObject;
                receivedNotification = info;
            };
            
            [observer setBlock:callback forState:state];
            
            [observer executeBlockForState:state object:notification];
        });
        
        afterEach(^{
            sender = nil;
            receivedNotification = nil;
        });
        
        it(@"should notify observers by sending observable object", ^{
            [[sender should] equal:observableObject];
        });
        
        it(@"should notify observers by sending object parameter", ^{
            [[notification should] equal:receivedNotification];
        });
    });
});

SPEC_END
