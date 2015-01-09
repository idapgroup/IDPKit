//
//  IDPStackArray.h
//  liverpool1
//
//  Created by Oleksa 'trimm' Korin on 7/4/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMutableArray.h"

// This is a classic LIFO buffer

@interface IDPStackArray : IDPMutableArray

- (void)push:(id)object;
- (void)pushArray:(NSArray *)objects;

- (id)pop;
- (NSArray *)popToObject:(id)object;

@end
