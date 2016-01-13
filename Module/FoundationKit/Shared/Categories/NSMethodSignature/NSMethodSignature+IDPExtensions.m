//
//  NSMethodSignature+IDPExtensions.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/13/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSMethodSignature+IDPExtensions.h"

#import "NSMutableString+IDPExtensions.h"

@implementation NSMethodSignature (IDPExtensions)

- (NSString *)objcTypesString {
    NSMutableString *result = [NSMutableString string];
    [result appendUTF8String:[self methodReturnType]];
    
    for (NSUInteger index = 0; index < [self numberOfArguments]; index++) {
        [result appendUTF8String:[self getArgumentTypeAtIndex:index]];
    }
    
    return [result copy];
}

@end
