//
//  IDPModelProxy.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/3/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPModelProxy.h"

#import "IDPModel.h"

@interface IDPModelProxy ()

@end

@implementation IDPModelProxy

#pragma mark -
#pragma mark Message Forwarding

- (void)forwardInvocation:(NSInvocation *)invocation {
    IDPModel *model = self.target;

    invocation.target = nil;
    [invocation invoke];
    
    NSUInteger resultLength = invocation.methodSignature.methodReturnLength;
    if (resultLength) {
        void *result = calloc(invocation.methodSignature.methodReturnLength, 1);
        [invocation setReturnValue:result];
        free(result);
    }
    
    [invocation retainArguments];
    invocation.target = model;
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invocation];
    [model executeOperation:operation];
}

@end
