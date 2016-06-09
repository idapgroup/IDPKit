//
//  IDPModelProxySpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/3/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPTestModel.h"
#import "IDPModelProxy.h"

#import "IDPSelector.h"

#import "IDPCompilerMacros.h"

typedef id(^IDPMethodStubBlock)(NSArray *parameters);

static NSString * const kIDPShortcutSelector                = @"kIDPShortcutSelector";
static NSString * const kIDPModelProxy                      = @"kIDPModelProxy";
static NSString * const kIDPParameter                       = @"kIDPParameter";
static NSString * const kIDPShortcutSelectorSharedExample   = @"shortcut selector";

SHARED_EXAMPLES_BEGIN(IDPModelProxyShortcutMethod)

sharedExamplesFor(kIDPShortcutSelectorSharedExample, ^(NSDictionary *data) {
    SEL selector = [(IDPSelector *)data[kIDPShortcutSelector] value];
    IDPModelProxy *proxy = data[kIDPModelProxy];
    IDPModel *model = proxy.target;
    id parameter = data[kIDPParameter];
    
    it(@"should call targets shortcut method", ^{
        [[model should] receive:selector andReturn:nil withArguments:parameter];
        
        IDPClangIgnorePerformSelectorWarning({
            [proxy performSelector:selector withObject:parameter];
        });
    });
    
    it(@"shouldn't call the forwarding", ^{
        [[proxy shouldNot] receive:@selector(forwardInvocation:)];

        IDPClangIgnorePerformSelectorWarning({
            [proxy performSelector:selector withObject:parameter];
        });
    });
});

SHARED_EXAMPLES_END

SPEC_BEGIN(IDPModelProxySpec)

describe(@"IDPModelProxy", ^{
    __block IDPTestModel *model = nil;
    __block IDPTestModel *proxy = nil;
    
    beforeEach(^{
        model = [IDPTestModel new];
        
        proxy = [IDPModelProxy proxyWithTarget:model];
    });
    
    context(@"when sending messages", ^{
        it(@"should return nil for method returning object", ^{
            [[proxy.object should] beNil];
        });
        
        it(@"should return 0 for method returning NSUInteger", ^{
            [[theValue(proxy.value) should] beZero];
        });
        
        it(@"should return CGRectZero for method returning CGRect", ^{
            [[theValue(proxy.frame) should] equal:theValue(CGRectZero)];
        });
        
        it(@"should not raise, when void method implemented in model is called", ^{
            [[theBlock(^{ [proxy setObject:[NSObject new]]; }) shouldNot] raise];
        });
        
        it(@"should raise, when method not implemented in model is called", ^{
            [[theBlock(^{ [(id)proxy array]; }) should] raise];
        });
        
        it(@"should forward NSInvocationOperation to model, which updates the model after execution", ^{
            NSObject *object = [NSObject new];
            
            [model stub:@selector(executeOperation:) withBlock:^id (NSArray *array) {
                id operation = array[0];
                [[operation should] beMemberOfClass:[NSInvocationOperation class]];
                
                [operation start];
                
                return nil;
            }];
            
            [proxy setObject:object];
            
            [[proxy.object shouldEventually] equal:object];
        });
    });
    
    context(@"when sending shortcut method", ^{
        model = [IDPTestModel nullMock];
        proxy = [IDPModelProxy proxyWithTarget:model];
        id block = ^(id object) {};
        
        context(@"-executeOperation:", ^{
            itBehavesLike(kIDPShortcutSelectorSharedExample, @{ kIDPShortcutSelector : IDPSEL(executeOperation:),
                                                                kIDPModelProxy : proxy,
                                                                kIDPParameter : [NSOperation new] });
        });
        
        context(@"-executeBlock:", ^{
            itBehavesLike(kIDPShortcutSelectorSharedExample, @{ kIDPShortcutSelector : IDPSEL(executeBlock:),
                                                                kIDPModelProxy : proxy,
                                                                kIDPParameter : block });
        });
        
        context(@"-executeSyncBlock:", ^{
            itBehavesLike(kIDPShortcutSelectorSharedExample, @{ kIDPShortcutSelector : IDPSEL(executeSyncBlock:),
                                                                kIDPModelProxy : proxy,
                                                                kIDPParameter : block });
        });
    });
});

SPEC_END
