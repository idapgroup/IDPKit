//
//  IDPUnsafeReference.m
//  iOS
//
//  Created by Oleksa Korin on 19/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPUnsafeReference.h"

@interface IDPUnsafeReference ()
@property (nonatomic, assign) id<NSObject> object;

@end

@implementation IDPUnsafeReference

@synthesize object  = _object;

@end
