//
//  IDPLocking.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/4/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/NSLock.h>

#import "IDPBlockTypes.h"

@protocol IDPLocking <NSObject, NSLocking>

- (void)performBlock:(IDPVoidBlock)block;

@end

#define IDPSynthesizeLockingInterface(class) \
    @interface class (__IDPLockingExtensions__##class) <IDPLocking> \
    @end

IDPSynthesizeLockingInterface(NSLock)
IDPSynthesizeLockingInterface(NSRecursiveLock)
IDPSynthesizeLockingInterface(NSCondition)
IDPSynthesizeLockingInterface(NSConditionLock)

#undef IDPSynthesizeLockingInterface
