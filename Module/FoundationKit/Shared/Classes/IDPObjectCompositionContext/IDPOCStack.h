//
//  IDPOCStack.h
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPMutableArray.h"

// contains only unique entries

@interface IDPOCStack : IDPMutableArray

// adds the object to the end of an array
// if the object is alreaady in the stack,
// moves it to the top of the stack
- (void)addObject:(id)anObject;

@end