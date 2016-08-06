//
//  IDPKVOObserver.h
//  iOS
//
//  Created by Oleksa Korin on 9/3/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPKVONotification;

@interface IDPKVOObserver : NSObject
@property (nonatomic, readonly) IDPKVONotification  *notification;
@property (nonatomic, readonly) void                *context;

@end
