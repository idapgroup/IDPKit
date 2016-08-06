//
//  IDPKVOObserver.m
//  iOS
//
//  Created by Oleksa Korin on 9/3/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPKVOObserver.h"

#import "IDPKVONotification.h"

@interface IDPKVOObserver ()
@property (nonatomic, strong) IDPKVONotification  *notification;
@property (nonatomic, assign) void                *context;

@end

@implementation IDPKVOObserver

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    self.notification = [IDPKVONotification notificationWithObject:object
                                                           keyPath:keyPath
                                                 changesDictionary:change];
    
    self.context = context;
}

@end
