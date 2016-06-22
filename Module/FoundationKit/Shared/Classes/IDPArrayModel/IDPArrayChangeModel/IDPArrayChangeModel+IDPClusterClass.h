//
//  IDPArrayChangeModel+IDPClusterClass.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayChangeModel.h"

@interface IDPArrayChangeModel (IDPClusterClass)

+ (instancetype)insertModelWithArray:(id)array index:(NSUInteger)index;
+ (instancetype)removeModelWithArray:(id)array index:(NSUInteger)index;
+ (instancetype)replaceModelWithArray:(id)array index:(NSUInteger)index;
+ (instancetype)moveModelWithArray:(id)array index:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;
+ (instancetype)compoundModelWithArray:(id)array changeModels:(NSArray *)changeModels;

@end
