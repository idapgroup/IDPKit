//
//  IDPCopyReference.h
//  iOS
//
//  Created by Oleksa Korin on 19/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPReference.h"

@interface IDPCopyReference : IDPReference

+ (id)referenceWithObject:(id<NSCopying, NSObject>)theObject;

@end
