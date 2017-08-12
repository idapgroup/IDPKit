//
//  IDPKVOMutableArraySpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/23/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPKVOMutableArray.h"
#import "IDPKVOController.h"
#import "NSObject+IDPKVO.h"

SPEC_BEGIN(IDPKVOMutableArraySpec)

describe(@"IDPKVOMutableArray", ^{
    context(@"when observing self", ^{
        let(array, ^{ return [IDPKVOMutableArray new]; });
        let(object, ^{ return [NSObject new]; });
        
        it(@"should notify, when object was added", ^{
            id block = theBlockProxy(^(id object) {});
            
//            [array.container observeKeyPath:@"array" handler:^(IDPKVONotification *notification) {
//                NSLog(@"");
//            }];
//            
//            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 2)];
//            [array insertObjects:@[object, object] atIndexes:indexSet];
        });
    });
});

SPEC_END
