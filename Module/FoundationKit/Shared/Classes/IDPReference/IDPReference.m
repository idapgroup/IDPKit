//
//  IDPReference.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPReference.h"

#import "NSObject+IDPExtensions.h"

@interface IDPReference ()
@property (nonatomic, readwrite) id object;
@end

@implementation IDPReference

@dynamic object;

#pragma mark -
#pragma mark Class Methods

+ (id)referenceWithObject:(id)theObject {
    IDPReference *reference = [self object];
    reference.object = theObject;
    
    return reference;
}

#pragma mark -
#pragma mark Public

- (NSString *)description {
    return [NSString stringWithFormat:@"%@: %@", [super description], self.object];
}

#pragma mark -
#pragma mark Comparison

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        IDPReference *reference = (IDPReference *)object;
        return self.object == reference.object;
    }
    
    return NO;
}

- (NSUInteger)hash {
    return (NSUInteger)self.object;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    IDPReference *reference = [[[self class] referenceWithObject:self.object] retain];
    
    return reference;
}

@end
