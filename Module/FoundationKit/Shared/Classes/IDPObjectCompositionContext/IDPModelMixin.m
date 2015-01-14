//
//  IDPModelMixin.m
//  liverpool1
//
//  Created by Denis Halabuzar on 7/11/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPModelMixin.h"

@interface IDPModelMixin ()
@property (nonatomic, assign)   id<IDPModel> target;
@end

@implementation IDPModelMixin

@synthesize target  = _target;

#pragma mark -
#pragma mark Class methods

+ (instancetype)modelWithTarget:(id<IDPModel>)target {
    IDPModelMixin *me = [self new];
    if (me) {
        me.target = target;
    }
    
    return me;
}

@end
