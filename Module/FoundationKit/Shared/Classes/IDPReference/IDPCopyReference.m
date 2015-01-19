//
//  IDPCopyReference.m
//  iOS
//
//  Created by Oleksa Korin on 19/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPCopyReference.h"

@interface IDPCopyReference ()
@property (nonatomic, copy) id<NSCopying, NSObject> object;

@end

@implementation IDPCopyReference

@synthesize object   = _object;

#pragma mark -
#pragma mark Class Methods

+ (id)referenceWithObject:(id<NSCopying, NSObject>)theObject {
    IDPCopyReference *reference = [self new];
    reference.object = theObject;
    
    return reference;
}

@end
