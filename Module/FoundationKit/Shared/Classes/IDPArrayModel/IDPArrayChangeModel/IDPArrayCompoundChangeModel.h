//
//  IDPArrayCompoundChangeModel.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayChangeModel.h"

@interface IDPArrayCompoundChangeModel : IDPArrayChangeModel
@property (nonatomic, copy, readonly) NSArray     *changeModels;

+ (instancetype)modelWithArray:(id)array changeModels:(NSArray *)changeModels;

- (instancetype)initWithArray:(id)array changeModels:(NSArray *)changeModels;

@end
