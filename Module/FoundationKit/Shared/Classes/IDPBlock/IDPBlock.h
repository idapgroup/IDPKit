//
//  IDPBlock.h
//  AudioStretcher
//
//  Created by Oleksa 'trimm' Korin on 3/12/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPBlock : NSObject

+ (void)performOnMainQueue:(void (^)(void))block waitUntilDone:(BOOL)YesOrNo;

@end
