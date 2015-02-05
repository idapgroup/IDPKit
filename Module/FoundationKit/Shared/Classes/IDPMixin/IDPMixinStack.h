//
//  IDPMixinStack.h
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMutableArray.h"

// contains only unique entries

@interface IDPMixinStack : NSObject
@property (nonatomic, readonly)     NSArray *mixins;

// adds the object to the end of an array
// if the object is alreaady in the stack,
// moves it to the top of the stack
- (void)addObject:(id)anObject;

- (void)removeObject:(id)anObject;

- (BOOL)containsObject:(id)anObject;

- (NSUInteger)count;

@end