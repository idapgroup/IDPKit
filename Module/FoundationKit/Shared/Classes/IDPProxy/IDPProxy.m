//
//  IDPProxy.m
//  iOS
//
//  Created by Oleksa Korin on 9/3/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPProxy.h"

@interface IDPProxy ()
@property (nonatomic, strong) id    target;

@end

@implementation IDPProxy

#pragma mark -
#pragma mark Class Methods

+ (id)proxyWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithTarget:(id)target {
    if (self) {
        self.target = target;
    }
    
    return self;
}

#pragma mark -
#pragma mark Forwarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [self.target methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

#pragma mark -
#pragma mark Target Mimicking

- (BOOL)isMemberOfClass:(Class)aClass {
    return [self.target isMemberOfClass:aClass]
            || [super isMemberOfClass:aClass];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [self.target isKindOfClass:aClass]
            || [super isKindOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = [super respondsToSelector:aSelector];
    result = result || [self.target respondsToSelector:aSelector];
    
    return result;
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ proxy for target:\n%@",
            self,
            self.target];
}

- (Class)class {
    return [self.target class];
}

#pragma mark -
#pragma mark Comparison

- (NSUInteger)hash {
    return [self.target hash];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[IDPProxy class]]) {
        object = [object target];
    }
    
    return [self.target isEqual:object];
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return [[self class] proxyWithTarget:[self.target copy]];
}

@end
