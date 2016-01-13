//
//  NSMethodSignature+IDPExtensionsSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/13/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Kiwi.h>

#import "NSMethodSignature+IDPExtensions.h"

typedef void(^IDPObjcTypesBlock)(NSString *, NSString *, Class, SEL);
typedef void(^IDPObjcTypesPropertyBlock)(NSString *, SEL, SEL);

static NSString * const kIDPVoid    = @"void";

SPEC_BEGIN(NSMethodSignature_IDPExtensionsSpec)

describe(@"NSMethodSignature+IDPExtensions", ^{
    IDPObjcTypesBlock objcTypesStringCheck = ^(NSString *returnString, NSString *parameterString, Class class, SEL selector) {
        NSString *contextDescription = [NSString stringWithFormat:@"%@  return, %@ parameter method ", returnString, parameterString];
        context(contextDescription, ^{
            __block NSMethodSignature *originalSignature = nil;
            __block NSMethodSignature *signature = nil;
            
            beforeEach(^{
                originalSignature = [class instanceMethodSignatureForSelector:selector];
                signature = [NSMethodSignature signatureWithObjCTypes:[[originalSignature objcTypesString] UTF8String]];
            });
            
            it(@"shouldn't return nil for objcTypesString", ^{
                [[[signature objcTypesString] shouldNot] beNil];
                [[[originalSignature objcTypesString] shouldNot] beNil];
            });
            
            it(@"should return the same objcTypesString as original signature", ^{
                [[[originalSignature objcTypesString] should] equal:[signature objcTypesString]];
            });
            
            it(@"should equal original signature", ^{
                [[originalSignature should] equal:signature];
            });
        });
    };
    
    context(@"created with objcTypesString result of a signature with", ^{
        Class class = [UIView class];
        
        IDPObjcTypesPropertyBlock objcTypesStringPropertyCheck = ^(NSString *propertyTypeString, SEL getter, SEL setter) {
            objcTypesStringCheck(propertyTypeString, kIDPVoid, class, getter);
            objcTypesStringCheck(kIDPVoid, propertyTypeString, class, setter);
        };
        
        objcTypesStringPropertyCheck(@"struct", @selector(frame), @selector(setFrame:));
        objcTypesStringPropertyCheck(@"object", @selector(backgroundColor), @selector(setBackgroundColor:));
        objcTypesStringPropertyCheck(@"primitive", @selector(alpha), @selector(setAlpha:));
        
        objcTypesStringCheck(@"struct", @"struct and primnitives", class, @selector(systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority:));
    });
});

SPEC_END

