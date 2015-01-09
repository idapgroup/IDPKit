//
//  IDPBufferArray.h
//  liverpool1
//
//  Created by Oleksa 'trimm' Korin on 7/4/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMutableArray.h"

// This is a classic FIFO buffer

@interface IDPBufferArray : IDPMutableArray

- (void)push:(id)object;
- (id)pop;

@end
