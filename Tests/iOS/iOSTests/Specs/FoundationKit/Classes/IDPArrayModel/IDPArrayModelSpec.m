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
    
    let(objects, ^{ return [NSObject objectsWithCount:count]; });
    let(arrayModelProxy, ^{ return [IDPArrayModel modelWithArray:objects]; });
    let(arrayModel, ^{ return (IDPArrayModel *)[arrayModelProxy target]; });
    let(model, ^{ return arrayModel[index]; });
    let(object, ^{ return [NSObject new]; });
    let(containedObject, ^{ return objects[index]; });
    
    context(@"when created", ^{
        specify(^{ [[arrayModel should] haveCountOf:count]; });
        specify(^{ [[arrayModel.objects should] equal:objects]; });
    });
    
    context(@"non-mutating method", ^{
        context(@"-objectAtIndex:", ^{
            specify(^{ [[[arrayModel objectAtIndex:index] should] equal:containedObject]; });
            specify(^{ [[theBlock(^{ [arrayModel objectAtIndex:count]; }) shouldNot] raise]; });
        });
        
        context(@"-objectAtIndexedSubscript:", ^{
            specify(^{ [[arrayModel[index] should] equal:containedObject]; });
            specify(^{ [[theBlock(^{ __unused id value = arrayModel[count]; }) shouldNot] raise]; });
        });
        
        context(@"-indexOfObject:", ^{
            specify(^{ [[theValue([arrayModel indexOfObject:containedObject]) should] equal:theValue(index)]; });
            specify(^{ [[theValue([arrayModel indexOfObject:object]) should] equal:theValue(NSNotFound)]; });
        });
        
        context(@"-containsObject:", ^{
            specify(^{ [[theValue([arrayModel containsObject:containedObject]) should] beYes]; });
            specify(^{ [[theValue([arrayModel containsObject:object]) should] beNo]; });
        });
    });
    
    context(@"mutating method", ^{
        context(@"-addObject:", ^{
            specify(^{
                [arrayModel addObject:object];
                [[theValue([arrayModel indexOfObject:object]) should] equal:theValue(count)];
            });
            
            specify(^{ [[theBlock(^{ [arrayModel addObject:nil]; }) shouldNot] raise]; });
        });
        
        context(@"-removeObject:", ^{
            specify(^{
                [arrayModel removeObject:containedObject];
                [[theValue([arrayModel indexOfObject:containedObject]) should] equal:theValue(NSNotFound)];
            });
            
            specify(^{ [[theBlock(^{ [arrayModel removeObject:nil]; }) shouldNot] raise]; });
        });
        
        context(@"-removeObjectAtIndex:", ^{
            specify(^{
                [arrayModel removeObjectAtIndex:index];
                [[arrayModel[index] shouldNot] equal:containedObject];
            });
            
            specify(^{ [[theBlock(^{ [arrayModel removeObjectAtIndex:count]; }) shouldNot] raise]; });
        });
        
        context(@"-setObject:atIndexedSubscript:", ^{
            specify(^{
                arrayModel[index] = object;
                [[arrayModel[index] should] equal:object];
            });
            
            specify(^{
                arrayModel[index] = nil;
                [[arrayModel[index] shouldNot] equal:containedObject];
            });
            
            specify(^{ [[theBlock(^{  arrayModel[index] = nil; }) shouldNot] raise]; });
            
            specify(^{
                arrayModel[count] = object;
                [[arrayModel[count] should] equal:object];
            });
        });
        
        context(@"-moveObjectAtIndex:toIndex:", ^{
            specify(^{ [[theBlock(^{ [arrayModel moveObjectAtIndex:index toIndex:count]; }) shouldNot] raise]; });
            specify(^{ [[theBlock(^{ [arrayModel moveObjectAtIndex:count toIndex:index]; }) shouldNot] raise]; });
            
            specify(^{
                NSUInteger toIndex = count - 1;
                
                [arrayModel moveObjectAtIndex:index toIndex:toIndex];
                [[arrayModel[index] shouldNot] equal:containedObject];
                [[arrayModel[toIndex] should] equal:containedObject];
            });
        });
        
        context(@"-insertObject:atIndex:", ^{
            specify(^{
                [arrayModel insertObject:object atIndex:count];
                [[arrayModel[count] should] equal:object];
            });
            
            specify(^{
                [arrayModel insertObject:object atIndex:index];
                [[arrayModel[index] should] equal:object];
            });
            
            specify(^{
                [arrayModel insertObject:nil atIndex:index];
                [[arrayModel[index] should] equal:containedObject];
            });
        });

        context(@"-replaceObjectAtIndex:withObject:", ^{
            specify(^{ [[theBlock(^{ [arrayModel replaceObjectAtIndex:count withObject:object]; }) shouldNot] raise]; });
            specify(^{ [[theBlock(^{ [arrayModel replaceObjectAtIndex:index withObject:nil]; }) shouldNot] raise]; });

            specify(^{
                [arrayModel replaceObjectAtIndex:index withObject:object];
                [[arrayModel[index] should] equal:object];
            });
        });
    });
});

SPEC_END
