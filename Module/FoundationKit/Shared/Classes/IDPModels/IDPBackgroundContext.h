//
//  IDPContext.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/3/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

@class IDPModel;

#import "IDPBackgroundOperation.h"

@interface IDPBackgroundContext : IDPBackgroundOperation
@property (nonatomic, readonly) id model;

+ (instancetype)contextWithModel:(IDPModel *)model;

- (instancetype)initWithModel:(IDPModel *)model;

@end
