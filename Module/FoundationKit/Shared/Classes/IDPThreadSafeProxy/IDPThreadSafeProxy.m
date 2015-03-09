//
//  IDPThreadSafeProxy.m
//  iOS
//
//  Created by Oleksa Korin on 9/3/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPThreadSafeProxy.h"

@interface IDPThreadSafeProxy ()

@end

@implementation IDPThreadSafeProxy

#pragma mark -
#pragma mark Forwarding

- (void)forwardInvocation:(NSInvocation *)invocation {
    id target = self.target;
    
    @synchronized (target) {
        [invocation setTarget:target];
        [invocation invoke];
    }
}

@end
