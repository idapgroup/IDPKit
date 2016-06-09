//
//  IDPTestObject.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPTestObject.h"

#import "IDPReturnMacros.h"

@implementation IDPTestObject

- (NSUInteger)hash {
    return [self.object hash] ^ self.value;
}

- (BOOL)isEqual:(IDPTestObject *)object {
    IDPReturnValueIfNil(object || [self isMemberOfClass:[object class]], NO);
    IDPReturnValueIfNil(object != self, YES);
    
    return [self.object isEqual:object.object] && self.value == object.value;
}

@end
