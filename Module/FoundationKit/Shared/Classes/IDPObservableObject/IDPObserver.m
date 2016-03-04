//
//  IDPObserver.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 2/25/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPObserver.h"

#import "IDPObservableObject.h"

#import "IDPLocking.h"
#import "IDPBlockMacros.h"

@interface IDPObserver ()
@property (nonatomic, weak)     IDPObservableObject     *observableObject;
@property (nonatomic, weak)     id                      observingObject;
@property (nonatomic, strong)   NSMapTable              *mapTable;
@property (nonatomic, strong)   id<IDPLocking>          lock;

@end

@implementation IDPObserver

@dynamic valid;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithObservingObject:(id)observingObject observableObject:(IDPObservableObject *)observableObject {
    self = [super init];
    self.observableObject = observableObject;
    self.observingObject = observingObject;
    self.mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn
                                          valueOptions:NSMapTableCopyIn];
    
    self.lock = [NSRecursiveLock new];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isValid {
    return nil == self.observableObject;
}

#pragma mark -
#pragma mark Public

- (void)setBlock:(IDPObserverCallback)block forState:(IDPObjectState)state {
    NSMapTable *mapTable = self.mapTable;
    id stateObject = @(state);
    
    [self.lock performBlock:^{
        if (block) {
            [mapTable setObject:block forKey:stateObject];
        } else {
            [mapTable removeObjectForKey:stateObject];
        }
    }];
}

- (IDPObserverCallback)blockForState:(IDPObjectState)state {
    NSMapTable *mapTable = self.mapTable;
    
    __block id result = nil;
    [self.lock performBlock:^{
        result = [mapTable objectForKey:@(state)];
    }];
    
    return result;
}

- (id)objectAtIndexedSubscript:(NSUInteger)state {
    return [self blockForState:state];
}

- (void)setObject:(id)block atIndexedSubscript:(NSUInteger)state {
    [self setBlock:block forState:state];
}

- (void)executeBlockForState:(IDPObjectState)state object:(id)object {
    IDPObserverCallback block = self[state];
    IDPBlockCall(block, self.observableObject.target, object);
}

@end
