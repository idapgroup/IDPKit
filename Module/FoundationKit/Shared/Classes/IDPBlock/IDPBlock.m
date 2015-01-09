//
//  IDPBlock.m
//  AudioStretcher
//
//  Created by Oleksa 'trimm' Korin on 3/12/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPBlock.h"

@implementation IDPBlock

+ (void)performOnMainQueue:(void (^)(void))block waitUntilDone:(BOOL)YesOrNo {
    if (YesOrNo) {
        dispatch_sync(dispatch_get_main_queue(), block);
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

@end
