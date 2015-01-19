//
//  IDPStrongReference.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPStrongReference.h"

@interface IDPStrongReference ()
@property (nonatomic, strong) id<NSObject> object;

@end

@implementation IDPStrongReference

@synthesize object  = _object;

@end
