//
//  IDPObjectCompositionIMP.h
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPOCImplementation : NSObject

@property (nonatomic, assign)   IMP forwardingInvocationForSelectorIMP;
@property (nonatomic, assign)   IMP respondsToSelectorIMP;

@end
