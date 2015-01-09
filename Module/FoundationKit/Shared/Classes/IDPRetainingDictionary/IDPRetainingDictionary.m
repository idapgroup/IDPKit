//
//  IDPRetainingDictionary.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPRetainingDictionary.h"

#import "IDPRetainingReference.h"

@interface IDPRetainingDictionary ()
@property (nonatomic, retain) NSMutableArray    *keysCache;
@end

@implementation IDPRetainingDictionary

@synthesize keysCache      = _keysCache;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.keysCache = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark NSDictionary

- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys {
    NSMutableArray *references = [NSMutableArray arrayWithCapacity:[keys count]];
    for (id<NSObject> key in keys) {
        [references addObject:[IDPRetainingReference referenceWithObject:key]];
    }
    
    self = [super initWithObjects:objects forKeys:references];
    if (self) {
    }
    
    return self;
}

- (id)objectForKey:(id)aKey {
    IDPRetainingReference *reference = [IDPRetainingReference referenceWithObject:aKey];
    return [super objectForKey:reference];
}

- (NSEnumerator *)keyEnumerator {
    if (nil == self.keysCache) {
        self.keysCache = [NSMutableArray arrayWithCapacity:[self count]];
        NSArray *keys = [self allKeys];
        for (NSUInteger i = 0; i < [self count]; i++) {
            IDPReference *reference = [keys objectAtIndex:i];
            [self.keysCache addObject:reference.object];
        }
    }
    
    return [self.keysCache objectEnumerator];
}

#pragma mark -
#pragma mark NSMutableDictionary

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    self.keysCache = nil;
    IDPRetainingReference *reference = [IDPRetainingReference referenceWithObject:aKey];
    
    [super setObject:anObject forKey:reference];
}

- (void)removeObjectForKey:(id)aKey {
    self.keysCache = nil;
    IDPRetainingReference *reference = [IDPRetainingReference referenceWithObject:aKey];
    
    [super removeObjectForKey:reference];
}


@end
