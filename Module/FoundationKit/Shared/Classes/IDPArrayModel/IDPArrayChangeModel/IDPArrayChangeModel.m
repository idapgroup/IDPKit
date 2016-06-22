//
//  IDPArrayChangeModel.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayChangeModel.h"

#import "IDPReturnMacros.h"

@interface IDPArrayChangeModel ()
@property (nonatomic, weak) id  array;

@end

@implementation IDPArrayChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithArray:(id)array {
    return [[self alloc] initWithArray:array];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithArray:nil];
}

- (instancetype)initWithArray:(id)array {
    self = [super init];
    self.array = array;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)hash {
    return (NSUInteger)self.array;
}

- (BOOL)isEqual:(IDPArrayChangeModel *)object {
    IDPReturnValueIfNil(object || [self isMemberOfClass:[object class]], NO);
    IDPReturnValueIfNil(object != self, YES);
    
    return [self isEqualToChangeModel:object];
}

- (BOOL)isEqualToChangeModel:(IDPArrayChangeModel *)changeModel {
    return self.array == changeModel.array;
}

@end
