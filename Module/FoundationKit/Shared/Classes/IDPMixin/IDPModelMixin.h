//
//  IDPModelMixin.h
//  liverpool1
//
//  Created by Denis Halabuzar on 7/11/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPModel.h"

@interface IDPModelMixin : IDPModel

+ (instancetype)modelWithTarget:(id<IDPModel>)target;

@end
