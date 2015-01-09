//
//  IDPKVOMutableArray.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPKVOMutableArray.h"

#import "IDPKVOContext.h"

#import "NSObject+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

NSString * const kIDPKVOPathCount   = @"count";
NSString * const kIDPKVOPathArray   = @"array";

@interface IDPKVOMutableArray ()
@property (nonatomic, retain)   NSMutableArray    *array;
@property (nonatomic, retain)   NSMutableArray    *contexts;
@property (nonatomic, readonly) NSMutableArray    *mutableArrayValue;

// This method swizzles the keyPath count with array
- (NSString *)swizzleKeyPathForKeyPath:(NSString *)keyPath;

- (NSArray *)contextsWithObserver:(NSObject *)observer
                          keyPath:(NSString *)keyPath;

- (IDPKVOContext *)contextWithObserver:(NSObject *)observer
                               keyPath:(NSString *)keyPath
                               context:(void *)context;

@end

@implementation IDPKVOMutableArray

@synthesize array               = _array;
@synthesize contexts            = _contexts;

@dynamic mutableArrayValue;

#pragma mark -
#pragma mark Class Methods

+ (NSMutableArray *)array {
    return [self arrayWithArray:nil];
}
+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
    IDPKVOMutableArray *result = [self object];
    if (nil != array) {
        result.array = [NSMutableArray arrayWithArray:array];
    }
    
    return (NSMutableArray *)result;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.contexts = nil;    
    self.array = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.array = [NSMutableArray array];
        self.contexts = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSMutableArray *)mutableArrayValue {
    return [self mutableArrayValueForKey:kIDPKVOPathArray];
}

#pragma mark -
#pragma mark Message Forwarding

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    anInvocation.target = self.mutableArrayValue;
    [anInvocation invoke];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [self.mutableArrayValue methodSignatureForSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.mutableArrayValue;
}

#pragma mark -
#pragma mark KVO Hacks

// these hacks are required in order to observe
// count keypath instead of array property

- (void)addObserver:(NSObject *)anObserver
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(void *)context
{
    IDPKVOContext *contextObject = [self contextWithObserver:anObserver
                                               keyPath:keyPath
                                               context:context];
    contextObject.options = options;
    
    [super addObserver:self
            forKeyPath:[self swizzleKeyPathForKeyPath:keyPath]
               options:options
               context:contextObject];
}

- (void)removeObserver:(NSObject *)anObserver
            forKeyPath:(NSString *)keyPath
{
    [super removeObserver:self
               forKeyPath:[self swizzleKeyPathForKeyPath:keyPath]];
    
    NSArray *contextsToRemove = [self contextsWithObserver:anObserver
                                                   keyPath:keyPath];
    
    [self.contexts removeObjectsInArray:contextsToRemove];
}

- (void)removeObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               context:(void *)context
{
    IDPKVOContext *contextObject = [self contextWithObserver:observer
                                                     keyPath:keyPath
                                                     context:context];

    [super removeObserver:self
               forKeyPath:[self swizzleKeyPathForKeyPath:keyPath]
                  context:contextObject];
    
    [self.contexts removeObject:contextObject];
}

- (NSString *)swizzleKeyPathForKeyPath:(NSString *)keyPath {
    if ([keyPath isEqualToString:kIDPKVOPathCount]) {
        return kIDPKVOPathArray;
    }
    
    return keyPath;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    IDPKVOContext *contextObject = (IDPKVOContext *)context;
    [contextObject.observer observeValueForKeyPath:contextObject.keyPath
                                          ofObject:self
                                            change:change
                                           context:contextObject.context];
}

#pragma mark -
#pragma mark Contexts Handling

- (NSArray *)contextsWithObserver:(NSObject *)observer
                          keyPath:(NSString *)keyPath
{
    IDPKVOContext *comparisonObject = [IDPKVOContext contextWithObserver:observer
                                                                 keyPath:keyPath
                                                                 options:0
                                                                 context:NULL];
    
    __block NSMutableArray *result = [NSMutableArray array];
    IDPArrayObjectsEnumerationBlock block = ^(id obj, NSUInteger idx, BOOL *stop) {
        IDPKVOContext *context = obj;
        if ([context isEqualToContext:comparisonObject]) {
            [result addObject:context];
        }
    };
    
    [self.contexts enumerateObjectsUsingBlock:block];
    
    return [NSArray arrayWithArray:result];
}

- (IDPKVOContext *)contextWithObserver:(NSObject *)observer
                               keyPath:(NSString *)keyPath
                               context:(void *)context
{
    IDPKVOContext *comparisonObject = [IDPKVOContext contextWithObserver:observer
                                                                 keyPath:keyPath
                                                                 options:0
                                                                 context:context];
    
    NSUInteger index = [self.contexts indexOfObject:comparisonObject];
    if (NSNotFound == index) {
        [self.contexts addObject:comparisonObject];
        return comparisonObject;
    }
    
    return [self.contexts objectAtIndex:index];
}

#pragma mark -
#pragma mark NSMutableArray Mimicking

+ (BOOL)isSubclassOfClass:(Class)aClass {
    return [NSMutableArray isSubclassOfClass:aClass]
    || [super isSubclassOfClass:aClass];
}

+ (BOOL)instancesRespondToSelector:(SEL)aSelector {
    return [NSMutableArray instancesRespondToSelector:aSelector]
    || [super instancesRespondToSelector:aSelector];
}

+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *result = [super instanceMethodSignatureForSelector:aSelector];
    if (!result) {
        result = [NSMutableArray instanceMethodSignatureForSelector:aSelector];
    }
    
    return result;
}

+ (IMP)instanceMethodForSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return [super instanceMethodForSelector:aSelector];
    }
    
    return [NSMutableArray instanceMethodForSelector:aSelector];
}

- (IMP)methodForSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return [super methodForSelector:aSelector];
    }
    
    return [NSMutableArray instanceMethodForSelector:aSelector];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [self.array isKindOfClass:aClass]
    || [super isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [self.array isMemberOfClass:aClass]
    || [super isMemberOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = [super respondsToSelector:aSelector];
    result = result || [self.array respondsToSelector:aSelector];
    
    return result;
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ proxy object:\n%@",
            NSStringFromClass([self class]),
            [self.array description]];
}

@end
