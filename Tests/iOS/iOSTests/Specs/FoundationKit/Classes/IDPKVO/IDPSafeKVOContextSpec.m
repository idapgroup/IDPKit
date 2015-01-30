//
//  IDPSafeKVOContextSpec.m
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import <objc/runtime.h>

#import "IDPSafeKVOContext.h"

#import "IDPObjCRuntime.h"
#import "IDPKVOTestObject.h"

#import "NSObject+IDPRuntimeExtensions.h"

@interface IDPKVOObserver : NSObject
@end

@implementation IDPKVOObserver

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    
}

@end



SPEC_BEGIN(IDPSafeKVOContextSpec)

describe(@"Apple KVO", ^{
    context(@"when observing the object", ^{
        __block IDPKVOTestObject *object = nil;
        __block IDPKVOObserver *observer = nil;
        
        beforeAll(^{
            object = [IDPKVOTestObject new];
            object.value = 1;
            object.object = [NSObject new];
            
            observer = [IDPKVOObserver new];
            
            [object addObserver:observer
                     forKeyPath:IDPStringFromSEL(value)
                        options:NSKeyValueObservingOptionNew
                        context:NULL];
        });
        
        it(@"its -class should return IDPKVOTestObject", ^{
            [[[object class] should] equal:[IDPKVOTestObject class]];
        });
        
        it(@"its -isa should be NSKVONotifying_IDPKVOTestObject", ^{
            NSString *className = [NSString stringWithFormat:@"NSKVONotifying_%@",
                                   NSStringFromClass([IDPKVOTestObject class])];
            
            [[[object isa] should] equal:NSClassFromString(className)];
        });
        
        it(@"its -isa superclass should be IDPKVOTestObject", ^{
            [[[[object isa] superclass] should] equal:[IDPKVOTestObject class]];
        });
        
        context(@"after adding another observed keypath -object", ^{
            __block Class isa = Nil;
            
            beforeAll(^{
                isa = [object isa];
                
                [object addObserver:observer
                         forKeyPath:IDPStringFromSEL(object)
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
            });
            
            afterAll(^{
                [object removeObserver:observer
                            forKeyPath:IDPStringFromSEL(object)];
            });
            
            it(@"its -class should return IDPKVOTestObject", ^{
                [[[object class] should] equal:[IDPKVOTestObject class]];
            });
            
            it(@"its -isa should be NSKVONotifying_IDPKVOTestObject", ^{
                NSString *className = [NSString stringWithFormat:@"NSKVONotifying_%@",
                                       NSStringFromClass([IDPKVOTestObject class])];
                
                [[[object isa] should] equal:NSClassFromString(className)];
            });
            
            it(@"its -isa superclass should be IDPKVOTestObject", ^{
                [[[[object isa] superclass] should] equal:[IDPKVOTestObject class]];
            });
            
            it(@"its -isa pointer after adding should equal isa before adding", ^{
                [[theValue([object isa]) should] equal:theValue(isa)];
            });
        });
        
        context(@"after removing all observers", ^{
            beforeAll(^{
                [object removeObserver:observer
                            forKeyPath:IDPStringFromSEL(value)];
            });
            
            it(@"its -isa should equal its -class", ^{
                [[[object isa] should] equal:[object class]];
            });
            
            it(@"its -isa should be IDPKVOTestObject", ^{
                [[[object isa] should] equal:[IDPKVOTestObject class]];
            });
            
            it(@"its KVO class counterpart shouldn't be destroyed", ^{
                Class isa = [object KVOClass];
                [[theValue(isa) shouldNot] equal:theValue(nil)];
            });
        });
    });
});

describe(@"IDPSafeKVOContext", ^{
    
});

SPEC_END
