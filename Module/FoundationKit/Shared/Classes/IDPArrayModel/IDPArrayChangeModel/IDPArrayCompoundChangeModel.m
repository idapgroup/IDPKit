//
//  IDPArrayCompoundChangeModel.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayCompoundChangeModel.h"

@interface IDPArrayCompoundChangeModel ()
@property (nonatomic, copy) NSArray     *changeModels;

@end

@implementation IDPArrayCompoundChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithArray:(id)array changeModels:(NSArray *)changeModels {
    return [[self alloc] initWithArray:array changeModels:changeModels];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithArray:(id)array {
    return [self initWithArray:array changeModels:nil];
}

- (instancetype)initWithArray:(id)array changeModels:(NSArray *)changeModels {
    self = [super initWithArray:array];
    self.changeModels = changeModels;
    
    return self;
}

@end
