//
//  IDPKVOKeyPathBindings.m
//  iOS
//
//  Created by trimm on 7/6/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPKVOKeyPathBindings.h"
#import "IDPKVONotification.h"

#import "IDPTestObject.h"
#import "IDPKVOObserver.h"
#import "IDPSelector.h"
#import "IDPBlockTypes.h"

static NSString * const kIDPKVOCallbackSharedExample   = @"kvo callback";

static NSString * const kIDPBindings            = @"kIDPBindings";
static NSString * const kIDPKeyPath             = @"kIDPKeyPath";
static NSString * const kIDPOptions             = @"kIDPOptions";
static NSString * const kIDPContext             = @"kIDPContext";
static NSString * const kIDPValue               = @"kIDPValue";
static NSString * const kIDPTransformBlock      = @"kIDPTransformBlock";

SHARED_EXAMPLES_BEGIN(IDPKVOKeyPathBindings)

sharedExamplesFor(kIDPKVOCallbackSharedExample, ^(NSDictionary *data) {
    IDPKVOObserver *observer = [IDPKVOObserver new];
    
    IDPKVOKeyPathBindings *bindings = data[kIDPBindings];
    void *context = (void *)[data[kIDPContext] unsignedIntegerValue];
    
    id optionsObject = data[kIDPOptions];
    optionsObject = optionsObject ? optionsObject : theValue(NSKeyValueObservingOptionNew);
    
    id bridgeKeyPath = data[kIDPKeyPath];
    IDPVoidBlock block = data[kIDPTransformBlock];
    
    id value = data[kIDPValue];
    
    beforeAll(^{
        [bindings bindKeyPath:bridgeKeyPath
                  forObserver:observer
                      options:[optionsObject unsignedIntegerValue]
                      context:context];
        
        block();
    });
    
    afterAll(^{
        [bindings unbindKeyPath:bridgeKeyPath
                    forObserver:observer
                        context:context];
    });
    
    specify(^{ [[observer.notification.value should] equal:value]; });
    specify(^{ [[theValue(observer.notification.changeType) should] equal:optionsObject]; });
    specify(^{ [[observer.notification.object should] equal:bindings.bridge]; });
    specify(^{ [[observer.notification.keyPath should] equal:bridgeKeyPath]; });
    specify(^{ [[theValue(observer.context) should] equal:theValue(context)]; });
});

SHARED_EXAMPLES_END

SPEC_BEGIN(IDPKVOKeyPathBindingsSpec)

describe(@"IDPKVOKeyPathBindings", ^{
    const NSUInteger value = 10;
    NSObject *objectValue = [NSObject new];
    
    id bridge = [NSObject new];
    IDPTestObject *object = [IDPTestObject new];
    
    id objectKeyPath = IDPStringFromSEL(value);
    id bridgeKeyPath = @"bridgeValue";

    id keyPath = IDPStringFromSEL(object);
    
    id keyPathBindings = @{ bridgeKeyPath : objectKeyPath };
    
    IDPKVOKeyPathBindings *bindings = [IDPKVOKeyPathBindings bindingsWithBridge:bridge
                                                                         object:object
                                                                keyPathBindings:keyPathBindings];

    
    context(@"when initilized with object, bridge and keypath bindings", ^{
        it(@"should contain object", ^{
            [[[bindings bridge] should] equal:bridge];
        });
        
        it(@"should contain bridge", ^{
            [[[bindings object] should] equal:object];
        });
        
        it(@"should contain keypath bindings", ^{
            [[[bindings keyPathBindings] should] equal:keyPathBindings];
        });
    });
    
    context(@"observer, when bound for keyPath with context", ^{
        itBehavesLike(kIDPKVOCallbackSharedExample, @{
                                                      kIDPBindings: bindings,
                                                      kIDPKeyPath: bridgeKeyPath,
                                                      kIDPValue: theValue(value),
                                                      kIDPTransformBlock: ^{ object.value = value; }
                                                      });
    });
    
    context(@"observer, when bound for keypath not in bindings dictionary", ^{
        itBehavesLike(kIDPKVOCallbackSharedExample, @{
                                                      kIDPBindings: bindings,
                                                      kIDPKeyPath: keyPath,
                                                      kIDPValue: objectValue,
                                                      kIDPTransformBlock: ^{ object.object = objectValue; }
                                                      });
    });
    
    context(@"observers, when bound for keypath with context", ^{
        it(@"should observe KVO changes of bridge", ^{
            
        });
    });
    
    context(@"observer, when bound with context = NULL", ^{
        it(@"should receive observeValueForKeyPath:ofObject:change:context:", ^{
            
        });
        
        context(@"when updating options", ^{
            it(@"should observe keypath with new options", ^{
                
            });
        });
        
        context(@"observer, when unbound with context = NULL", ^{
            it(@"shouldn't receive the observeValueForKeyPath:ofObject:change:context:", ^{

            });
        });
    });
    
    context(@"observer, when bound with 2 contexts", ^{
        it(@"it should receive observeValueForKeyPath:ofObject:change:context: twice", ^{
            
        });
        
        context(@"observer, when unbound with context = NULL", ^{
            it(@"should call the observeValueForKeyPath:ofObject:change:context: once", ^{
                
            });
            
            context(@"observer, when unbound with context = value", ^{
                it(@"shouldn't receive observeValueForKeyPath:ofObject:change:context:", ^{
                    
                });
            });
        });
    });
    
    context(@"observer, when bound with 2 contexts", ^{
        it(@"it should receive observeValueForKeyPath:ofObject:change:context: twice", ^{
            
        });
        
        context(@"when observer stops observing IDPTestObject with context = NULL", ^{
            it(@"should call the observeValueForKeyPath:ofObject:change:context: once", ^{
                
            });
            
            context(@"when observer stops observing IDPTestObject with context = value", ^{
                it(@"shouldn't call the observeValueForKeyPath:ofObject:change:context:", ^{
                    
                });
            });
        });
    });
    
    context(@"observer, when bound with 2 contexts", ^{
        it(@"it should receive observeValueForKeyPath:ofObject:change:context: twice", ^{
            
        });
        
        context(@"observer, when unvound without context", ^{
            it(@"should remove random observer from observation", ^{

            });
        });
    });
});

SPEC_END
