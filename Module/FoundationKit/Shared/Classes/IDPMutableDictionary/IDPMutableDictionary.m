//
//  IDPMutableDictionary.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMutableDictionary.h"

@interface IDPMutableDictionary ()
@property (nonatomic, retain) NSMutableDictionary   *dictionary;
@end

@implementation IDPMutableDictionary

@synthesize dictionary      = _dictionary;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.dictionary = nil;
    
    [super dealloc];
}

// although docs say, that initWithObjects:forKeys: is the
// designated initializer, it actually fails without this method

- (id)init {
    self = [super init];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (id)initWithCapacity:(NSUInteger)numItems {
    self = [super init];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionaryWithCapacity:numItems];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSDictionary

- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys {
    self = [super init];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionaryWithObjects:objects
                                                             forKeys:keys];
    }
    
    return self;
}

- (NSUInteger)count {
    return [self.dictionary count];
}

- (id)objectForKey:(id)aKey {
    return [self.dictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator {
    return [self.dictionary keyEnumerator];
}

#pragma mark -
#pragma mark NSMutableDictionary

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    [self.dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey {
    [self.dictionary removeObjectForKey:aKey];
}

@end
