//
//  IDPObservableObjectSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 2/25/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPObservableObject.h"

SPEC_BEGIN(IDPObservableObjectSpec)

describe(@"IDPObservableObject", ^{
    const NSUInteger state = 150;
    
    __block IDPObservableObject *object = nil;
    __block IDPObserver *observer = nil;

    beforeEach(^{
        object = [IDPObservableObject new];
        observer = [object observer];
    });
    
    afterEach(^{
        object = nil;
        observer = nil;
    });
    
    context(@"when initialized without target", ^{
        it(@"should have target = self", ^{
            [[object should] equal:object.target];
        });
    });
    
    context(@"after being deallocated", ^{
        beforeEach(^{
            object = nil;
        });
        
        it(@"should remove all observers", ^{
            [[theValue(observer.valid) should] beNo];
        });
        
        it(@"should be removed from observers of observable object", ^{
            observer = nil;
            [[object.observers should] haveCountOf:0];
        });
    });
    
    context(@"after fetching observer", ^{
        describe(@"IDPObserver", ^{
            it(@"should contain observable object in its obsevable object property", ^{
                [[observer.observableObject should] equal:object];
            });
        });
    });
    
    context(@"when observer starts observing", ^{
        it(@"should add observer into its observers", ^{
            [[object.observers should] containObjects:observer, nil];
        });
        
        it(@"should return IDPObserver object", ^{
            [[observer should] beKindOfClass:[IDPObserver class]];
        });
        
        context(@"multiple times", ^{
            it(@"should return multiple unique observer objects", ^{
                id anotherObserver = [object observer];
                [[anotherObserver shouldNot] equal:observer];
            });
        });
    });
    
    context(@"when object changes state", ^{
        __block id sender = nil;
        __block id receivedNotification = nil;
        
        beforeEach(^{
            id callback = ^(id observableObject, id info) {
                sender = observableObject;
                receivedNotification = info;
            };
            
            [observer setBlock:callback forState:state];
        });
    
        afterEach(^{
            sender = nil;
            receivedNotification = nil;
        });
        
        context(@"and sends changes in notification", ^{
            __block id notification = nil;
            
            beforeEach(^{
                notification = [NSObject new];
                
                [object setState:state object:notification];
            });
            
            afterEach(^{
                notification = nil;
            });
            
            it(@"should notify observers by sending self", ^{
                [[sender should] equal:object];
            });
            
            it(@"should notify observers by sending changes", ^{
                [[receivedNotification should] equal:notification];
            });
        });
        
        context(@"and doesn't send changes in notification", ^{
            beforeEach(^{
                object.state = state;
            });
            
            it(@"should notify observers by sending self", ^{
                [[sender should] equal:object];
            });
            
            it(@"should notify observers by sending changes", ^{
                [[receivedNotification should] beNil];
            });
        });
    });
    
    context(@"when notifying of state", ^{
        __block id sender = nil;
        __block id receivedNotification = nil;
        
        beforeEach(^{
            id callback = ^(id observableObject, id info) {
                sender = observableObject;
                receivedNotification = info;
            };
            
            [observer setBlock:callback forState:state];
        });
        
        afterEach(^{
            sender = nil;
            receivedNotification = nil;
        });
        
        context(@"and sends changes in notification", ^{
            __block id notification = nil;
            
            beforeEach(^{
                notification = [NSObject new];
                
                [object notifyObserversWithState:state object:object];
            });
            
            afterEach(^{
                notification = nil;
            });
            
            it(@"should notify observers by sending self", ^{
                [[sender should] equal:object];
            });
            
            it(@"should notify observers by sending changes", ^{
                [[receivedNotification should] equal:notification];
            });
        });
        
        context(@"and doesn't send changes in notification", ^{
            beforeEach(^{
                [object notifyObserversWithState:state];
            });
            
            it(@"should notify observers by sending self", ^{
                [[sender should] equal:object];
            });
            
            it(@"should notify observers by sending changes", ^{
                [[receivedNotification should] beNil];
            });
        });
    });
    
    context(@"when initialized with target", ^{
        id target = [NSObject new];
        
        beforeEach(^{
            object = [IDPObservableObject objectWithTarget:target];
            observer = [object observer];
        });
        
        it(@"should have target = target", ^{
            [[target should] equal:object.target];
        });
        
        context(@"when object changes state", ^{
            __block id sender = nil;
            
            beforeEach(^{
                id callback = ^(id observableObject, id info) {
                    sender = observableObject;
                };
                
                [observer setBlock:callback forState:state];
            });
            
            afterEach(^{
                sender = nil;
            });
            
            it(@"should notify observers by sending self", ^{
                [[sender should] equal:target];
            });
        });
    });
});

SPEC_END
