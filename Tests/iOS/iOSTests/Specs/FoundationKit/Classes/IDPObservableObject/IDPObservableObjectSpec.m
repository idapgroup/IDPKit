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
        
        context(@"when using performBlockWithNotifications", ^{
            context(@"when using notify", ^{
                it(@"should notify", ^{
                    [[callback should] beEvaluated];
                    
                    [object performBlockWithNotifications:^{ [object notifyObserversWithState:state]; }];
                });
            });
            
            context(@"when state changes", ^{
                it(@"should notify", ^{
                    [[callback should] beEvaluated];
                    
                    [object performBlockWithNotifications:^{ object.state = state;; }];
                });
            });
        });
        
        context(@"when using performBlockWithoutNotifications", ^{
            context(@"when using notify", ^{
                it(@"shouldn't notify", ^{
                    [[callback shouldNot] beEvaluated];
                    
                    [object performBlockWithoutNotifications:^{ [object notifyObserversWithState:state]; }];
                });
            });
            
            context(@"when state changes", ^{
                it(@"shouldn't notify", ^{
                    [[callback shouldNot] beEvaluated];

                    [object performBlockWithoutNotifications:^{ object.state = state; }];
                });
            });
        });
        
        context(@"when nesting performBlockWithNotifications and performBlockWithoutNotifications", ^{
            const NSUInteger state1 = state + 1;
            const NSUInteger state2 = state + 2;
            const NSUInteger state3 = state + 3;
            const NSUInteger state4 = state + 4;
            
            id callback1 = theBlockProxy(^(id observableObject, id info) { });
            id callback2 = theBlockProxy(^(id observableObject, id info) { });
            id callback3 = theBlockProxy(^(id observableObject, id info) { });
            id callback4 = theBlockProxy(^(id observableObject, id info) { });
            
            beforeEach(^{
                observer[state1] = callback1;
                observer[state2] = callback2;
                observer[state3] = callback3;
                observer[state4] = callback4;
            });
            
            it(@"should notify only states set in performBlockWithNotifications", ^{
                [[callback should] beEvaluated];
                [[callback1 shouldNot] beEvaluated];
                [[callback2 should] beEvaluated];
                [[callback3 shouldNot] beEvaluated];
                [[callback4 should] beEvaluated];
                
                [object performBlockWithNotifications:^{
                    object.state = state;
                    
                    [object performBlockWithoutNotifications:^{
                        object.state = state1;
                        
                        [object performBlockWithNotifications:^{
                            object.state = state2;
                        }];
                        
                        object.state = state3;
                    }];
                    
                    object.state = state4;
                }];
            });
        });
    });
});

SPEC_END
