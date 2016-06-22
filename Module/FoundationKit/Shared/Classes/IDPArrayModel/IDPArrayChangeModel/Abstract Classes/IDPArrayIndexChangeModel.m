//
//  IDPArrayIndexChangeModel.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayIndexChangeModel.h"

@interface IDPArrayIndexChangeModel ()
@property (nonatomic, assign)   NSUInteger  index;

@end

@implementation IDPArrayIndexChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithArray:(id)array index:(NSUInteger)index {
    return [[self alloc] initWithArray:array index:index];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithArray:(id)array {
    return [self initWithArray:array index:0];
}

- (instancetype)initWithArray:(id)array index:(NSUInteger)index {
    self = [super initWithArray:array];
    self.index = index;
    
    return self;
}

@end
