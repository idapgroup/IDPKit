//
//  IDPKVONotification.m
//  iOS
//
//  Created by Oleksa Korin on 29/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPKVONotification.h"

@interface IDPKVONotification ()
@property (nonatomic, weak)     id                  object;
@property (nonatomic, copy)     NSString            *keyPath;
@property (nonatomic, assign)   NSKeyValueChange    changeType;
@property (nonatomic, strong)   id                  value;
@property (nonatomic, strong)   id                  oldValue;

@property (nonatomic, assign, getter = isPrior)   BOOL  prior;

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
    return [self.object hash]
            ^ [self.keyPath hash]
            ^ self.changeType
            ^ [self.value hash]
            ^ [self.oldValue hash]
            ^ [self isPrior];
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
            && [self.value isEqual:notification.value]
            && [self.oldValue isEqual:notification.oldValue]
            && self.prior == notification.prior;
}

#pragma mark -
#pragma mark Private

- (void)fillWithChangesDictionary:(NSDictionary *)dictionary {
    NSNumber *changeType = dictionary[NSKeyValueChangeKindKey];
    self.changeType = [changeType unsignedIntegerValue];

    self.value = dictionary[NSKeyValueChangeNewKey];
    self.oldValue = dictionary[NSKeyValueChangeOldKey];
    self.prior = [dictionary[NSKeyValueChangeNotificationIsPriorKey] boolValue];
}

@end
