//
//  IDPMixinStack.m
//  iOS
//
//  Created by Oleksa Korin on 16/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPMixinStack.h"

SPEC_BEGIN(IDPMixinStackSpec)

describe(@"IDPMixinStack", ^{
    context(@"when empty", ^{
        let(stack, ^id{
            return [IDPMixinStack new];
        });
        
        it(@"its count should be 0", ^{
            [[theValue([stack count]) should] equal:theValue(0)];
        });
    });
    
    context(@"when adding object", ^{
        __block IDPMixinStack *stack = nil;
        __block NSObject *object = nil;
        
        beforeAll(^{
            stack = [IDPMixinStack new];
            object = [NSObject new];
            
            [stack addObject:object];
        });
        
        it(@"its count should be 1", ^{
            [[theValue([stack count]) should] equal:theValue(1)];
        });
        
        it(@"it should contain that object", ^{
            [[[stack firstObject] should] equal:object];
        });
        
        context(@"after adding another object", ^{
            beforeAll(^{
                [stack addObject:[NSObject new]];
            });
            
            context(@"after reading object at index 0", ^{
                beforeAll(^{
                    object = [stack firstObject];
                    [stack addObject:object];
                });
                
                it(@"its count should be 2", ^{
                    [[theValue([stack count]) should] equal:theValue(2)];
                });
                
                it(@"it should move object at index 0 to the last index", ^{
                    [[[stack lastObject] should] equal:object];
                });
            });
        });
    });
});

SPEC_END