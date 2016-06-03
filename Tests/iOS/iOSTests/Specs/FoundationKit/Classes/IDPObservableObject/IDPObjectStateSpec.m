//
//  IDPObjectStateSpec.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/3/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "Kiwi.h"

#import "IDPObjectState.h"

IDPObjectState(IDPTestState,
               IDPTestStateLoading,
               IDPTestStateLoaded);

IDPObjectStateChild(IDPTestChildState, IDPTestState,
                    IDPTestChildStateUploaded);

IDPObjectStateChild(IDPTestNextChildState, IDPTestChildState,
                    IDPTestNextChildStateNext);

static NSString * const kIDPFirstParentState    = @"kIDPFirstParentState";
static NSString * const kIDPLastParentState     = @"kIDPLastParentState";
static NSString * const kIDPFirstChildState     = @"kIDPFirstChildState";

static NSString * const kIDPStateInheritanceSharedExample   = @"kIDPStateInheritanceSharedExample";

SHARED_EXAMPLES_BEGIN(IDPObjectStateInheritance)

sharedExamplesFor(kIDPStateInheritanceSharedExample, ^(NSDictionary *data) {
    id firstParentState = data[kIDPLastParentState];
    id lastParentState = data[kIDPLastParentState];
    id firstChildState = data[kIDPFirstChildState];
    
    it(@"should have first content state inequal to first parent state", ^{
        [[firstParentState shouldNot] equal:firstChildState];
    });
    
    it(@"should have it first content state equal to last content state of parent + 1", ^{
        [[firstChildState should] equal:theValue([lastParentState unsignedIntegerValue] + 1)];
    });
});

SHARED_EXAMPLES_END

SPEC_BEGIN(IDPObjectStateSpec)

describe(@"IDPObjectState", ^{
    context(@"when IDPTestState is root state", ^{
        it(@"should contain undefined as first enum value", ^{
           [[theValue(IDPTestStateUndefined) should] equal:theValue(0)];
        });
    });
    
    context(@"when IDPTestChildState inherits IDPTestState", ^{
        itBehavesLike(kIDPStateInheritanceSharedExample, @{ kIDPFirstParentState : theValue(IDPTestStateLoading),
                                                            kIDPLastParentState : theValue(IDPTestStateLoaded),
                                                            kIDPFirstChildState : theValue(IDPTestChildStateUploaded)});
    });
    
    context(@"when IDPTestNextChildState inherits IDPTestChildState", ^{
        itBehavesLike(kIDPStateInheritanceSharedExample, @{ kIDPFirstParentState : theValue(IDPTestChildStateUploaded),
                                                            kIDPLastParentState : theValue(IDPTestChildStateUploaded),
                                                            kIDPFirstChildState : theValue(IDPTestNextChildStateNext)});
    });
});

SPEC_END

