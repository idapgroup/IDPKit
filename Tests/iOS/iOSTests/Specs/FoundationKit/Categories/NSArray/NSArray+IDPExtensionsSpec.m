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

static NSString * const kIDPObjectArrayFactorySharedExample   = @"kIDPObjectArrayFactorySharedExample";

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
});

SPEC_END
