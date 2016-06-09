//
//  IDPArrayModelSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/9/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPArrayModel.h"

#import "NSObject+IDPExtensions.h"

SPEC_BEGIN(IDPArrayModelSpec)

describe(@"IDPArrayModel", ^{
    NSUInteger count = 5;
    NSUInteger index = 3;
    
    let(arrayModelProxy, ^{ return [IDPArrayModel modelWithArray:[NSObject objectsWithCount:count]]; });
    let(arrayModel, ^{ return (IDPArrayModel *)[arrayModelProxy target]; });
    let(model, ^{ return arrayModel[index]; });
    let(object, ^{ return [NSObject new]; });
    
    context(@"when adding object", ^{
        specify(^{
            [arrayModel addObject:object];

            [[theValue([arrayModel indexOfObject:object]) should] equal:theValue(count)];
        });
    });
    
    
});

SPEC_END
