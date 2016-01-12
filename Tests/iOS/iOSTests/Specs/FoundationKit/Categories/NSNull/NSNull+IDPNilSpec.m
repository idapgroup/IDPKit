//
//  NSNull+IDPNilSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/12/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Kiwi.h>

#import "NSNull+IDPNil.h"

SPEC_BEGIN(NSNull_IDPNilSpec)

describe(@"NSNull+IDPNil", ^{
    context(@"when sending unknown message ", ^{
        context(@"with void return type", ^{
            it(@"shouldn't throw", ^{
                
            });
        });
        
        context(@"with object return type", ^{
            it(@"shouldn't throw", ^{
                
            });
            
            it(@"should return nil", ^{
                
            });
        });
        
        context(@"with primitive value return type", ^{
            it(@"shouldn't throw", ^{
                
            });
            
            it(@"should return 0", ^{
                
            });
        });
        
        context(@"with struct value return type", ^{
            it(@"shouldn't throw", ^{
                
            });
            
            it(@"should return 0", ^{
                
            });
        });
    });
    
    context(@"when sending NSNull methods", ^{
        it(@"shouldn't throw", ^{
            
        });
    });
    
    context(@"when comparing", ^{
        it(@"should return YES, when comparing with nil", ^{
            
        });
        
        it(@"should return YES, when comparing with NSNull", ^{
            
        });
        
        it(@"should return NO, when comparing with any other object", ^{
            
        });
        
        it(@"should return same hash for two NSNull objects", ^{
            
        });
    });

});

SPEC_END
