//
//  NSObject+IDPMixinPrivate.h
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPMixinIMP;
@class IDPMixinStack;

@interface NSObject (IDPMixinPrivate)
@property (nonatomic, retain)   IDPMixinStack   *stack;

+ (void)setImplementation:(IDPMixinIMP *)object;
+ (IDPMixinIMP *)implementation;

@end
