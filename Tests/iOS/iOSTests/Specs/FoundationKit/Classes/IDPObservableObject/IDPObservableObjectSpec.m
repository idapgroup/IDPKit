//
//  IDPObservableObjectSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 2/25/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPObservableObject.h"

#import "IDPOwnershipMacros.h"

SPEC_BEGIN(IDPObservableObjectSpec)

describe(@"IDPObservableObject", ^{
    const NSUInteger state = 150;
    
    __block IDPObservableObject *object = nil;
    __block IDPObserver *observer = nil;
    
    beforeEach(^{
        @autoreleasepool {
            object = [IDPObservableObject new];
            observer = [object observer];
        }
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
    });
    
    context(@"after deallocationg observer", ^{
        beforeEach(^{
            observer = nil;            
        });
        
        it(@"should be removed from observers of observable object", ^{
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
    
    context(@"when notifying", ^{
        id callback = theBlockProxy(^(id observableObject, id info) { });
        id notification = [NSObject new];
        
        beforeEach(^{
            [observer setBlock:callback forState:state];
        });
        
        context(@"when object changes state", ^{
            context(@"and sends changes in notification", ^{
                it(@"should notify observers by sending self and changes", ^{
                    [[callback should] beEvaluatedWithArguments:observer, notification];
                    
                    [object setState:state object:notification];
                });
            });
            
            context(@"and doesn't send changes in notification", ^{
                it(@"should notify observers by sending self and nil", ^{
                    [[callback should] beEvaluatedWithArguments:observer, nil];
                    
                    object.state = state;
                });
            });
        });
        
        context(@"when notifying of state", ^{
            context(@"and sends changes in notification", ^{
                it(@"should notify observers by sending self and changes", ^{
                    [[callback should] beEvaluatedWithArguments:observer, notification];
                    
                    [object notifyObserversWithState:state object:notification];
                });
            });
            
            context(@"and doesn't send changes in notification", ^{
                it(@"should notify observers by sending self and nil", ^{
                    [[callback should] beEvaluatedWithArguments:observer, nil];
                    
                    [object notifyObserversWithState:state];
                });
            });
        });
        
        context(@"when initialized with target", ^{
            id target = [NSObject new];
            
            beforeEach(^{
                object = [IDPObservableObject objectWithTarget:target];
                observer = [object observer];
                
                [observer setBlock:callback forState:state];
            });
            
            it(@"should have target = target", ^{
                [[target should] equal:object.target];
            });
            
            context(@"when object changes state", ^{
                it(@"should notify observers by sending self", ^{
                    [[callback should] beEvaluatedWithArguments:target, nil];
                    
                    object.state = state;
                });
            });
        });
    });
});

SPEC_END
