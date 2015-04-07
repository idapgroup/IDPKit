//
//  IDPEnumerationThreadSafeProxy.m
//  iOS
//
//  Created by Oleksa Korin on 4/7/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPEnumerationThreadSafeProxy.h"

static NSString * const IDPEnumeratorSubstring     = @"enumerator";

@implementation IDPEnumerationThreadSafeProxy

#pragma mark -
#pragma mark Forwarding

- (void)forwardInvocation:(NSInvocation *)invocation {
    id target = self.target;
    
    NSString *selector = NSStringFromSelector(invocation.selector);
    if ([[selector lowercaseString] containsString:IDPEnumeratorSubstring]
        && [target respondsToSelector:@selector(copy)])
    {
        @synchronized(target) {
            [invocation setTarget:[target copy]];
            [invocation invoke];
        }
    } else {
        [super forwardInvocation:invocation];
    }
}

@end
