//
//  IDPLockingSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/4/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPLocking.h"

SPEC_BEGIN(IDPLockingSpec)

describe(@"IDPLocking", ^{
    __block NSArray *locks = nil;
    id block = ^{ NSLog(@""); };
    beforeEach(^{
        locks = @[[NSLock new],
                  [NSRecursiveLock new],
                  [NSCondition new],
                  [NSConditionLock new]];
    });
    
    context(@"when performing block", ^{
        it(@"should receive lock and unlock", ^{
            for (id lock in locks) {
                [[lock should] receive:@selector(lock)];
                [[lock should] receive:@selector(unlock)];
                [lock performBlock:block];
            }
        });
    });
    
    context(@"when performing block = nil", ^{
        it(@"shouldn't receive lock and unlock", ^{
            for (id lock in locks) {
                [[lock shouldNot] receive:@selector(lock)];
                [[lock shouldNot] receive:@selector(unlock)];
                [lock performBlock:nil];
            }
        });
    });
});

SPEC_END
