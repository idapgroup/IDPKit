//
//  NSNull+IDPNilSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/12/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Kiwi.h>

#import "NSNull+IDPNil.h"

typedef void(^IDPSELBlock)(SEL selector);

SPEC_BEGIN(NSNull_IDPNilSpec)

describe(@"NSNull+IDPNil", ^{
    NSNull *nullValue = [NSNull new];
    id value = nullValue;
    
    IDPSELBlock shouldNotRaiseBlock = ^(SEL selector) {
        it(@"shouldn't raise", ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [[theBlock(^{ [nullValue performSelector:selector]; }) shouldNot] raise];
#pragma clang diagnostic pop
        });
    };
    
    context(@"when sending unknown message ", ^{
        context(@"with void return type", ^{
            shouldNotRaiseBlock(@selector(loadView));
        });
        
        context(@"with object return type", ^{
            shouldNotRaiseBlock(@selector(view));
            
            it(@"should return nil", ^{
                [[[value view] should] beNil];
            });
        });
        
        context(@"with primitive value return type", ^{
            shouldNotRaiseBlock(@selector(count));
            
            it(@"should return 0", ^{
                [[theValue([value count]) should] beZero];
            });
        });
        
        context(@"with struct value return type", ^{
            shouldNotRaiseBlock(@selector(frame));
            
            it(@"should return empty struct", ^{
                CGRect frame = [value frame];
                [[theValue(CGRectIsEmpty(frame)) should] beYes];
            });
        });
    });
    
    context(@"when sending NSNull methods", ^{
        shouldNotRaiseBlock(@selector(description));
        shouldNotRaiseBlock(@selector(class));
    });
    
    context(@"when comparing", ^{
        it(@"shouldn't raise", ^{
            [[theBlock(^{ [nullValue isEqual:[NSNull null]]; }) shouldNot] raise];
        });
        
        it(@"should return YES, when comparing with nil", ^{
            [[theValue([nullValue isEqual:nil]) should] beYes];
        });
        
        it(@"should return YES, when comparing with NSNull", ^{
            [[theValue([nullValue isEqual:[NSNull null]]) should] beYes];
        });
        
        it(@"should return YES, when comparing with self", ^{
            [[theValue([nullValue isEqual:nullValue]) should] beYes];
        });
        
        it(@"should return NO, when comparing with any other object", ^{
            [[theValue([nullValue isEqual:[NSObject new]]) should] beNo];
        });
        
        it(@"should return same hash for two NSNull objects", ^{
            [[theValue([nullValue hash]) should] equal:theValue([[NSNull null] hash])];
        });
    });

});

SPEC_END
