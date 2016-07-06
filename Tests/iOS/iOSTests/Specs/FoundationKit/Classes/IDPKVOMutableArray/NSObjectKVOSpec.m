//
//  NSObjectKVOSpec.m
//  iOS
//
//  Created by trimm on 7/6/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import <Foundation/Foundation.h>

#import "IDPTestObject.h"
#import "IDPKVONotification.h"
#import "IDPSelector.h"

SPEC_BEGIN(NSObjectKVOSpec)

describe(@"KVO", ^{
    id keyPath = IDPStringFromSEL(value);
    id block = theBlockProxy(^id(NSArray *params) {
        return nil;
    });
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew;
    
    IDPTestObject *object = [IDPTestObject new];
    id observer = [NSObject new];
    [observer stub:@selector(observeValueForKeyPath:ofObject:change:context:) withBlock:block];
    
    void *nullContext = NULL;
    void *valueContext = &nullContext;
    
//    context(@"when observer starts observing IDPTestObject with context = NULL", ^{
//        it(@"should call the observeValueForKeyPath:ofObject:change:context:", ^{
//            [[block should] beEvaluated];
//            
//            [object addObserver:observer
//                     forKeyPath:keyPath
//                        options:options
//                        context:nullContext];
//        });
//        
//        context(@"when observer stops observing IDPTestObject with context = NULL", ^{
//            it(@"shouldn't call the observeValueForKeyPath:ofObject:change:context:", ^{
//                [[block shouldNot] beEvaluated];
//                
//                [object removeObserver:observer forKeyPath:keyPath context:nullContext];
//                object.value += 1;
//            });
//        });
//    });
    
    context(@"when observer starts observing IDPTestObject with 2 contexts", ^{
        it(@"it should call the observeValueForKeyPath:ofObject:change:context: twice", ^{
            [[block should] beEvaluatedWithCount:2];
            
            [object addObserver:observer
                     forKeyPath:keyPath
                        options:options
                        context:nullContext];
            
            [object addObserver:observer
                     forKeyPath:keyPath
                        options:options
                        context:valueContext];
        });
        
        context(@"when observer stops observing IDPTestObject with context = NULL", ^{
            it(@"should call the observeValueForKeyPath:ofObject:change:context: once", ^{
                [[block should] beEvaluated];
                
                [object removeObserver:observer forKeyPath:keyPath context:nullContext];
                object.value += 1;
            });
            
            context(@"when observer stops observing IDPTestObject with context = value", ^{
                it(@"shouldn't call the observeValueForKeyPath:ofObject:change:context:", ^{
                    [[block shouldNot] beEvaluated];
                    
                    [object removeObserver:observer forKeyPath:keyPath context:valueContext];
                    object.value += 1;
                });
            });
        });
    });
    
    context(@"when observer starts observing IDPTestObject with 2 contexts", ^{
        it(@"it should call the observeValueForKeyPath:ofObject:change:context: twice", ^{
            [[block should] beEvaluatedWithCount:2];
            
            [object addObserver:observer
                     forKeyPath:keyPath
                        options:options
                        context:nullContext];
            
            [object addObserver:observer
                     forKeyPath:keyPath
                        options:options
                        context:valueContext];
        });
        
        context(@"when observer stops observing IDPTestObject with context = NULL", ^{
            it(@"should call the observeValueForKeyPath:ofObject:change:context: once", ^{
                [[block should] beEvaluated];
                
                [object removeObserver:observer forKeyPath:keyPath];
                object.value += 1;
            });
            
            context(@"when observer stops observing IDPTestObject with context = value", ^{
                it(@"shouldn't call the observeValueForKeyPath:ofObject:change:context:", ^{
                    [[block shouldNot] beEvaluated];
                    
                    [object removeObserver:observer forKeyPath:keyPath];
                    object.value += 1;
                });
            });
        });
    });
});

SPEC_END
