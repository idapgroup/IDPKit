//
//  IDPArrayTwoIndexChangeModel.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayTwoIndexChangeModel.h"

#import "IDPComparison.h"

@interface IDPArrayTwoIndexChangeModel ()
@property (nonatomic, assign)   NSUInteger  fromIndex;

@end

@implementation IDPArrayTwoIndexChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithArray:(id)array index:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    return [[self alloc] initWithArray:array index:index fromIndex:fromIndex];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithArray:(id)array index:(NSUInteger)index {
    return [self initWithArray:array index:index fromIndex:0];
}

- (instancetype)initWithArray:(id)array index:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    self = [super initWithArray:array index:index];
    self.fromIndex = fromIndex;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)hash {
    return self.fromIndex ^ NSUIntegerBitRotate([super hash], 2);
}

- (BOOL)isEqualToChangeModel:(IDPArrayTwoIndexChangeModel *)changeModel {
    return [super isEqualToChangeModel:changeModel] && self.fromIndex == changeModel.fromIndex;
}

@end
