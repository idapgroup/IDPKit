//
//  IDPSelectorSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/7/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import <objc/runtime.h>

#import "IDPSelector.h"

SPEC_BEGIN(IDPSelectorSpec)

describe(@"IDPSelector", ^{
    SEL valueSelector = @selector(value);
    __block IDPSelector *selector = nil;
    
    beforeEach(^{
        selector = [IDPSelector objectWithSelector:valueSelector];
    });
    
    context(@"when created with value selector", ^{
        it(@"should contain contain selector", ^{
            [[theValue(sel_isEqual(valueSelector, selector.value)) should] beTrue];
        });
    });
    
    context(@"when comparing to SEL", ^{
        it(@"should equal the value selector", ^{
            [[theValue([selector isEqualToSEL:valueSelector]) should] beTrue];
        });
    });
    
    context(@"when comparing to object", ^{
        it(@"should be equal, when object is IDPSelector with same selector", ^{
            [[theValue([selector isEqual:IDPSEL(value)]) should] beTrue];
        });
        
        it(@"should be equal, when comparing to self", ^{
            [[theValue([selector isEqual:selector]) should] beTrue];
        });
        
        it(@"shouldn't be equal, when comparing to IDPSelector with NULL value", ^{
            [[theValue([selector isEqual:[IDPSelector objectWithSelector:NULL]]) should] beFalse];
        });
        
        it(@"shouldn't be equal, when comparing to IDPSelector with other value", ^{
            [[theValue([selector isEqual:IDPSEL(value:withObjCType:)]) should] beFalse];
        });
        
        it(@"shouldn't be equal, when comparing to nil", ^{
            [[theValue([selector isEqual:nil]) should] beFalse];
        });
    });
});

SPEC_END

