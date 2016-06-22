//
//  IDPArrayIndexChangeModel.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayChangeModel.h"

@interface IDPArrayIndexChangeModel : IDPArrayChangeModel
@property (nonatomic, readonly)   NSUInteger  index;

+ (instancetype)modelWithArray:(id)array index:(NSUInteger)index;

- (instancetype)initWithArray:(id)array index:(NSUInteger)index NS_DESIGNATED_INITIALIZER;

@end
