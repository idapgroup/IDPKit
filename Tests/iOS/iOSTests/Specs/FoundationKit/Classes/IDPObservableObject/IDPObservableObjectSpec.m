//
//  IDPObservableObjectSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 2/25/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(IDPObservableObjectSpec)

describe(@"IDPObservableObjectSpec", ^{
    context(@"after being deallocated", ^{
        it(@"should remove all observers", ^{
            
        });
    });
    
    context(@"when observer starts observing", ^{
        it(@"should add observer into its observers", ^{
            
        });
        
        it(@"should return IDPObserver object", ^{
            
        });
        
        context(@"multiple times", ^{
            it(@"should return multiple unique observer objects", ^{
                
            });
        });
    });
    
    context(@"when observer stops observing", ^{
        it(@"should remove observer from its observers", ^{
            
        });
    });
    
    context(@"when object changes state", ^{
        context(@"and sends changes in notification", ^{
            it(@"should notify observers sending self and changes as parameters", ^{
                
            });
        });
        
        context(@"and doesn't send changes in notification", ^{
            it(@"should notify observers sending self and changes = nil as parameters", ^{
                
            });
        });
        
        context(@"when observer pauses observation", ^{
            it(@"shouldn't send notifications to that observer", ^{
                
            });
            
            it(@"should send notifications to other observers", ^{
                
            });
            
            context(@"when observer resumes observation", ^{
                it(@"should send notifications to all unpaused observers", ^{
                    
                });
            });
        });
    });
});

SPEC_END
