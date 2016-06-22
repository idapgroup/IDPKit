//
//  IDPArrayChangeModel+IDPClusterClass.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayChangeModel+IDPClusterClass.h"

#import "IDPArrayInsertChangeModel.h"
#import "IDPArrayReplaceChangeModel.h"
#import "IDPArrayRemoveChangeModel.h"
#import "IDPArrayMoveChangeModel.h"
#import "IDPArrayCompoundChangeModel.h"

@implementation IDPArrayChangeModel (IDPClusterClass)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)insertModelWithArray:(id)array index:(NSUInteger)index {
    return [IDPArrayInsertChangeModel modelWithArray:array index:index];
}

+ (instancetype)removeModelWithArray:(id)array index:(NSUInteger)index {
    return [IDPArrayRemoveChangeModel modelWithArray:array index:index];
}

+ (instancetype)replaceModelWithArray:(id)array index:(NSUInteger)index {
    return [IDPArrayReplaceChangeModel modelWithArray:array index:index];
}

+ (instancetype)moveModelWithArray:(id)array index:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    return [IDPArrayMoveChangeModel moveModelWithArray:array index:index fromIndex:fromIndex];
}

+ (instancetype)compoundModelWithArray:(id)array changeModels:(NSArray *)changeModels {
    return [IDPArrayCompoundChangeModel modelWithArray:array changeModels:changeModels];
}

@end
