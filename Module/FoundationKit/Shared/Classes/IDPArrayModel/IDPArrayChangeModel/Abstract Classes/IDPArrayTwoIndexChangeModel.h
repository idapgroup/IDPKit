//
//  IDPArrayTwoIndexChangeModel.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayIndexChangeModel.h"

@interface IDPArrayTwoIndexChangeModel : IDPArrayIndexChangeModel
@property (nonatomic, readonly)   NSUInteger  fromIndex;

+ (instancetype)modelWithArray:(id)array index:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;

- (instancetype)initWithArray:(id)array index:(NSUInteger)index fromIndex:(NSUInteger)fromIndex NS_DESIGNATED_INITIALIZER;

@end
