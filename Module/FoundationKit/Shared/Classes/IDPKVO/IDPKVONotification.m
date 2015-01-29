//
//  IDPKVONotification.m
//  iOS
//
//  Created by Oleksa Korin on 29/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPKVONotification.h"

@interface IDPKVONotification ()
@property (nonatomic, weak)     id<NSObject>        object;
@property (nonatomic, copy)     NSString            *keyPath;
@property (nonatomic, assign)   NSKeyValueChange    changeType;
@property (nonatomic, strong)   id<NSObject>        newValue;
@property (nonatomic, strong)   id<NSObject>        oldValue;

- (void)fillWithChangesDictionary:(NSDictionary *)dictionary;

@end

@implementation IDPKVONotification

#pragma mark -
#pragma mark Class Methods

+ (instancetype)notificationWithObject:(id<NSObject>)observedObject
                               keyPath:(NSString *)keyPath
                     changesDictionary:(NSDictionary *)changesDictionary
{
    return [[self alloc] initWithObject:observedObject
                                keyPath:keyPath
                      changesDictionary:changesDictionary];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithObject:(id<NSObject>)observedObject
                       keyPath:(NSString *)keyPath
             changesDictionary:(NSDictionary *)changesDictionary
{
    self = [super init];
    if (self) {
        self.object = observedObject;
        self.keyPath = keyPath;
        
        [self fillWithChangesDictionary:changesDictionary];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)hash {
    return [self.object hash] ^ [self.keyPath hash] ^ self.changeType ^ [self.newValue hash] ^ [self.oldValue hash];
}

- (BOOL)isEqual:(id)object {
    if (!object) {
        return NO;
    }
    
    if (self == object) {
        return YES;
    }
    
    if ([self isMemberOfClass:[object class]]) {
        if ([self hash] == [object hash]) {
            return [self isEqualToKVONotification:object];
        }
    }
    
    return NO;
}

- (BOOL)isEqualToKVONotification:(IDPKVONotification *)notification {
    return [self.object isEqual:notification.object]
            && [self.keyPath isEqual:notification.keyPath]
            && self.changeType == notification.changeType
            && [self.newValue isEqual:notification.newValue]
            && [self.oldValue isEqual:notification.oldValue];
}

#pragma mark -
#pragma mark Private

- (void)fillWithChangesDictionary:(NSDictionary *)dictionary {
    NSNumber *changeType = dictionary[NSKeyValueChangeKindKey];
    self.changeType = [changeType unsignedIntegerValue];

    self.newValue = dictionary[NSKeyValueChangeNewKey];
    self.oldValue = dictionary[NSKeyValueChangeOldKey];
}

@end
