//
//  IDPArrayChangeModel.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayChangeModel.h"

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

@end
