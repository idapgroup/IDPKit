//
//  NSArray+IDPExtensionsSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/9/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPTestObject.h"

#import "NSArray+IDPExtensions.h"

static NSString * const kIDPArrayClass    = @"kIDPArrayClass";

static NSString * const kIDPObjectArrayFactorySharedExample     = @"kIDPObjectArrayFactorySharedExample";
static NSString * const kIDPShuffledArraySharedExample          = @"kIDPShuffledArraySharedExample";

SHARED_EXAMPLES_BEGIN(IDPObjectArrayFactorySharedExample)

sharedExamplesFor(kIDPObjectArrayFactorySharedExample, ^(NSDictionary *data) {
    Class class = data[kIDPArrayClass];
    
    NSString *string = @"mama";
    NSUInteger count = 3;
    
    IDPFactoryBlock factory = ^ {
        IDPTestObject *object = [IDPTestObject new];
        object.object = string;
        object.value = count;
        
        return object;
    };
    
    let(array, ^id{
        return [class arrayWithCount:count factoryBlock:factory];
    });
    
    it([NSString stringWithFormat:@"should be %@", NSStringFromClass(class)], ^{
        [[array should] beKindOfClass:class];
    });
    
    it(@"should have count = 3", ^{
        [[array should] haveCountOf:count];
    });
    
    it(@"should have objects equaling factory produced object", ^{
        id referenceObject = factory();
        
        for (id object in array) {
            [[object should] equal:referenceObject];
        }
    });
});

sharedExamplesFor(kIDPShuffledArraySharedExample, ^(NSDictionary *data) {
    Class class = data[kIDPArrayClass];
    
    context(@"when array is empty", ^{
        it(@"should return new empty array", ^{
            id array = [class new];
            id shuffledArray = [array shuffledArray];
            
            [[shuffledArray should] haveCountOf:[array count]];
        });
    });
    
    context(@"when array has 1 object", ^{
        it(@"should return new array with same object", ^{
            id array = [class arrayWithArray:@[[NSObject new]]];
            id shuffledArray = [array shuffledArray];
            
            [[shuffledArray should] haveCountOf:[array count]];
            [[array[0] should] equal:shuffledArray[0]];
        });
    });
    
    context(@"when array has 3 objects", ^{
        let(array, ^id{
            return [class arrayWithArray:@[[NSObject new], [NSObject new], [NSObject new], [NSObject new]]];
        });
        
        it([NSString stringWithFormat:@"should be %@", NSStringFromClass(class)], ^{
            [[array should] beKindOfClass:class];
        });
        
        it(@"should return shuffled array", ^{
            NSUInteger count = [array count];
            
            id shuffledArray = [array shuffledArray];
            
            [[shuffledArray should] haveCountOf:count];
            [[array shouldNot] equal:shuffledArray];
            
            NSUInteger sameObjectsCount = 0;
            NSUInteger shuffleObjectsCount = 0;
            for (NSUInteger i = 0; i < [array count]; i++) {
                id object = array[i];
                NSUInteger shuffleIndex = [shuffledArray indexOfObject:object];
                if (shuffleIndex != NSNotFound) {
                    sameObjectsCount += 1;
                }
                
                if (i != shuffleIndex) {
                    shuffleObjectsCount += 1;
                }
            }
            
            [[shuffledArray should] haveCountOf:sameObjectsCount];
            [[theValue(shuffleObjectsCount) should] beGreaterThan:theValue(0)];
        });
    });

});


SHARED_EXAMPLES_END

SPEC_BEGIN(NSArray_IDPExtensionsSpec)

describe(@"NSArray+IDPExtensions", ^{
    context(@"+arrayWithCount:factoryBlock:", ^{
        context(@"NSArray", ^{
            itBehavesLike(kIDPObjectArrayFactorySharedExample, @{ kIDPArrayClass : [NSArray class] });
        });
        
        context(@"NSMutableArray", ^{
            itBehavesLike(kIDPObjectArrayFactorySharedExample, @{ kIDPArrayClass : [NSMutableArray class] });
        });
    });
    
    context(@"-randomObject", ^{
        context(@"when array is empty", ^{
            it(@"should return nil", ^{
                [[[[NSArray new] randomObject] should] beNil];
            });
        });
        
        context(@"when array has 1 object", ^{
            it(@"should return object from array", ^{
                id array = @[[NSObject new]];
                id object = [array randomObject];
                
                [[array should] contain:object];
            });
        });
        
        context(@"when array has 2 objects", ^{
            it(@"should return object from array", ^{
                id array = @[[NSObject new], [NSObject new]];
                id object = [array randomObject];
                
                [[array should] contain:object];
            });
        });
    });
    
    context(@"-shuffledArray", ^{
        context(@"NSArray", ^{
            itBehavesLike(kIDPShuffledArraySharedExample, @{ kIDPArrayClass : [NSArray class] });
        });
        
        context(@"NSMutableArray", ^{
            itBehavesLike(kIDPShuffledArraySharedExample, @{ kIDPArrayClass : [NSMutableArray class] });
        });
    });
});

SPEC_END
