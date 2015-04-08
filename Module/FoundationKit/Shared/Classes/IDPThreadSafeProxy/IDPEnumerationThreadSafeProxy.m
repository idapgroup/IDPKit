//
//  IDPEnumerationThreadSafeProxy.m
//  iOS
//
//  Created by Oleksa Korin on 4/7/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPEnumerationThreadSafeProxy.h"

#import "NSString+IDPExtensions.h"

static NSString * const IDPEnumeratorSubstring     = @"enumerator";

@implementation IDPEnumerationThreadSafeProxy

#pragma mark -
#pragma mark Forwarding

- (void)forwardInvocation:(NSInvocation *)invocation {
    id target = self.target;
    
    NSString *selector = NSStringFromSelector(invocation.selector);
    if ([selector containsCaseInsensitiveString:IDPEnumeratorSubstring]
        && [target respondsToSelector:@selector(copy)])
    {
        @synchronized(target) {
            target = [target copy];
            [invocation invokeWithTarget:target];
        }
    } else {
        [super forwardInvocation:invocation];
    }
}

@end
