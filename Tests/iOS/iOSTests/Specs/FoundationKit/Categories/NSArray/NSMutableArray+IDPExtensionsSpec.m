//
//  NSMutableArray+IDPExtensions.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/9/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "NSMutableArray+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

static NSString * const kIDPArrayFactory        = @"kIDPArrayFactory";
static NSString * const kIDPMoveIndex           = @"kIDPMoveIndex";
static NSString * const kIDPMoveToIndex         = @"kIDPMoveToIndex";

static NSString * const kIDPMutableArrayMoveSharedExample               = @"kIDPMutableArrayMoveSharedExample";
static NSString * const kIDPMutableArrayOutOfBoundsIndexSharedExample   = @"kIDPMutableArrayOutOfBoundsIndexSharedExample";

typedef NSMutableArray *(^IDPArrayFactory)();

SHARED_EXAMPLES_BEGIN(IDPMutableArraySharedExample)

sharedExamplesFor(kIDPMutableArrayOutOfBoundsIndexSharedExample, ^(NSDictionary *data) {
    IDPArrayFactory factory = data[kIDPArrayFactory];
    let(array, factory);
    
    it(@"should raise when index >= count", ^{
        [[theBlock(^{
            [array moveObjectAtIndex:[array count] toIndex:0];
        }) should] raise];
    });
    
    it(@"should raise when toIndex >= count", ^{
        [[theBlock(^{
            [array moveObjectAtIndex:0 toIndex:[array count]];
        }) should] raise];
    });
});

sharedExamplesFor(kIDPMutableArrayMoveSharedExample, ^(NSDictionary *data) {
    IDPArrayFactory factory = data[kIDPArrayFactory];
    NSUInteger index = [data[kIDPMoveIndex] unsignedIntegerValue];
    NSUInteger toIndex = [data[kIDPMoveToIndex] unsignedIntegerValue];

    context([NSString stringWithFormat:@"when moving from index %lu to index %lu", index, toIndex], ^{
        let(array, factory);
        let(originalArray, ^{ return [NSMutableArray arrayWithArray:array]; });
        let(object, ^{ return array[index]; });
        
        beforeEach(^{
            [array moveObjectAtIndex:index toIndex:toIndex];
        });
        
        it([NSString stringWithFormat:@"should have object at toIndex = %lu", toIndex], ^{
            [[array[toIndex] should] equal:object];
        });
        
        it([NSString stringWithFormat:@"should have object at index = %lu", index], ^{
            [[array[index] shouldNot] equal:object];
        });
        
        it(@"should have other objects in the same order", ^{
            [originalArray removeObject:object];
            [array removeObject:object];
            
            [[originalArray should] equal:array];
        });
    });
});

SHARED_EXAMPLES_END

SPEC_BEGIN(NSMutableArray_IDPExtensionsSpec)

describe(@"NSMutableArray+IDPExtensions", ^{
    context(@"-moveObjectAtIndex:toIndex:", ^{
        context(@"when array is empty", ^{
            IDPArrayFactory factory = ^{ return [NSMutableArray new]; };
            let(array, factory);
            
            it(@"should raise", ^{
                [[theBlock(^{
                    [array moveObjectAtIndex:0 toIndex:0];
                }) should] raise];
            });
            
            itBehavesLike(kIDPMutableArrayOutOfBoundsIndexSharedExample, @{ kIDPArrayFactory : factory });
        });
        
        context(@"when array contains 5 objects", ^{
            NSUInteger count = 5;
            
            IDPArrayFactory factory = ^{
                return [NSMutableArray arrayWithCount:count
                                         factoryBlock:^{ return [NSObject new]; }];
            };
            
            let(array, factory);
            
            itBehavesLike(kIDPMutableArrayOutOfBoundsIndexSharedExample, @{ kIDPArrayFactory : factory });
            
            it(@"shouldn't change when moving object from index 3 to index 3", ^{
                NSUInteger index = 3;
                id originalArray = [NSMutableArray arrayWithArray:array];
                
                [array moveObjectAtIndex:index toIndex:index];
                
                [[array should] equal:originalArray];
            });
            
            itBehavesLike(kIDPMutableArrayMoveSharedExample, @{ kIDPArrayFactory : factory,
                                                                kIDPMoveIndex : theValue(0),
                                                                kIDPMoveToIndex : theValue(count - 1) });
            
            itBehavesLike(kIDPMutableArrayMoveSharedExample, @{ kIDPArrayFactory : factory,
                                                                kIDPMoveIndex : theValue(count - 1),
                                                                kIDPMoveToIndex : theValue(0) });
            
            itBehavesLike(kIDPMutableArrayMoveSharedExample, @{ kIDPArrayFactory : factory,
                                                                kIDPMoveIndex : theValue(1),
                                                                kIDPMoveToIndex : theValue(3) });
            
            itBehavesLike(kIDPMutableArrayMoveSharedExample, @{ kIDPArrayFactory : factory,
                                                                kIDPMoveIndex : theValue(3),
                                                                kIDPMoveToIndex : theValue(1) });
            
            itBehavesLike(kIDPMutableArrayMoveSharedExample, @{ kIDPArrayFactory : factory,
                                                                kIDPMoveIndex : theValue(3),
                                                                kIDPMoveToIndex : theValue(2) });

            itBehavesLike(kIDPMutableArrayMoveSharedExample, @{ kIDPArrayFactory : factory,
                                                                kIDPMoveIndex : theValue(2),
                                                                kIDPMoveToIndex : theValue(3) });
        });
    });
});

SPEC_END
