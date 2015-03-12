//
//  NSObject+IDPKVO.h
//  iOS
//
//  Created by Oleksa Korin on 6/2/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPKVOController.h"

@interface NSObject (IDPKVO)

- (IDPKVOController *)observeKeyPath:(NSString *)keyPath
                         handler:(IDPKVONotificationBlock)block;

- (IDPKVOController *)observeKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                         handler:(IDPKVONotificationBlock)block;

- (IDPKVOController *)observeKeyPaths:(NSArray *)keyPaths
                          handler:(IDPKVONotificationBlock)block;

- (IDPKVOController *)observeKeyPaths:(NSArray *)keyPaths
                          options:(NSKeyValueObservingOptions)options
                          handler:(IDPKVONotificationBlock)block;

@end
