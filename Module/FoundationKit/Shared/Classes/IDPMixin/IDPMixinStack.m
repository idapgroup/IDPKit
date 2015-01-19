//
//  IDPMixinStack.m
//  PatiencePad
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMixinStack.h"

@interface IDPMixinStack ()
@property (nonatomic, strong)     NSMutableArray  *mutableMixins;

@end

@implementation IDPMixinStack

@dynamic mixins;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableMixins = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)mixins {
    @synchronized(self) {
        return [self.mutableMixins copy];
    }
}

#pragma mark -
#pragma mark Public

- (void)addObject:(id)anObject {
    @synchronized(self) {
        NSMutableArray *array = self.mutableMixins;
        [array removeObject:anObject];
        [array addObject:anObject];
    }
}

- (void)removeObject:(id)anObject {
    @synchronized(self) {
        [self.mutableMixins removeObject:anObject];
    }
}

- (BOOL)containsObject:(id<NSObject>)anObject {
    @synchronized(self) {
        return [self.mutableMixins containsObject:anObject];
    }
}

- (NSUInteger)count {
    @synchronized(self) {
        return [self.mutableMixins count];
    }
}

@end
