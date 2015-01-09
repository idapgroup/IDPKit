//
//  IDPWeakReference.m
//  ClipIt
//
//  Created by Oleksa 'trimm' Korin on 2/24/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPWeakReference.h"

@interface IDPWeakReference ()
@property (nonatomic, assign) id object;
@end

@implementation IDPWeakReference

@synthesize object   = _object;

@end
