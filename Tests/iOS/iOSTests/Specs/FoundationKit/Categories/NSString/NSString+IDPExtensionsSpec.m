//
//  NSString+IDPExtensionsSpec.m
//  iOS
//
//  Created by Alexander Kradenkov on 6/20/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Kiwi.h>
#import <XCTest/XCTest.h>

#import "NSString+IDPExtensions.h"

SPEC_BEGIN(NSString_IDPExtensionsSpec)

describe(@"NSString+IDPExtensions", ^{
    __block BOOL value;
    
    context(@"when value is YES", ^{
        beforeAll(^{
            value = YES;
        });
        
        let(categoryGeneratedstring, ^id{
            return [NSString stringWithBOOL:value];
        });
        
        let(macroGeneratedString, ^id{
            return IDPStringifyBOOL(value);
        });

        it(@"category method should return \"YES\"", ^{
            id isEqual = theValue([(NSString *)categoryGeneratedstring isEqualToString:@"YES"]);
            [[isEqual should] equal:@(YES)];
        });
        
        it(@"result of +stringWithBOOL: must be equal to IDPStringifyBOOL result", ^{
            [[macroGeneratedString should] equal:categoryGeneratedstring];
        });
    });
    
    context(@"when value is NO", ^{
        beforeAll(^{
            value = NO;
        });
        
        let(categoryGeneratedstring, ^id{
            return [NSString stringWithBOOL:value];
        });
        
        let(macroGeneratedString, ^id{
            return IDPStringifyBOOL(value);
        });
        
        it(@"category method should return \"NO\"", ^{
            id isEqual = theValue([(NSString *)categoryGeneratedstring isEqualToString:@"NO"]);
            [[isEqual should] equal:@(YES)];
        });
        
        it(@"result of +stringWithBOOL: must be equal to IDPStringifyBOOL result", ^{
            [[macroGeneratedString should] equal:categoryGeneratedstring];
        });
    });
});

SPEC_END