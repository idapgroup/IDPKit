//
//  NSObject+IDPOCExtensionsPrivate.h
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPOCImplementation;
@class IDPOCStack;

@interface NSObject (IDPOCExtensionsPrivate)

@property (nonatomic, retain)   IDPOCStack   *stack;

+ (void)setImplementation:(IDPOCImplementation *)object;
+ (IDPOCImplementation *)implementation;

@end
