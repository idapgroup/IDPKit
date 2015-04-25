//
//  IDPBackgroundOperationSpec.m
//  iOS
//
//  Created by Alexander Kradenkov on 4/25/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPBackgroundOperation.h"

SPEC_BEGIN(IDPBackgroundOperationSpec)

describe(@"IDPBackgroundOperation", ^{
    context(@"after operation object created", ^{
        IDPBackgroundOperation *operation = [IDPBackgroundOperation new];
        it(@"should be not nil", ^{
            [[operation shouldNot] beNil];
        });
        
        context(@"after empty operation being started", ^{
            [operation start];
            it(@"shoul finish immediately", ^{
                [[theValue(operation.isFinished) should] equal:@(YES)];
            });
        });
    });
});

SPEC_END