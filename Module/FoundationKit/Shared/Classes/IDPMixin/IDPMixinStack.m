//
//  IDPMixinStack.m
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMixinStack.h"

@implementation IDPMixinStack

#pragma mark -
#pragma mark Public

- (void)addObject:(id)anObject {
    if ([self containsObject:anObject]) {
        [self removeObject:anObject];
    }
    
    [super addObject:anObject];
}

@end
