//
//  IDPReference.h
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

// This is an abstract subclass, which
// should never be instantiated directly

@interface IDPReference : NSObject <NSCopying>

// this property is dynamic and both setter and getter
// should be created in the subclasses
@property (nonatomic, readonly) id object;

+ (id)referenceWithObject:(id)theObject;

@end
