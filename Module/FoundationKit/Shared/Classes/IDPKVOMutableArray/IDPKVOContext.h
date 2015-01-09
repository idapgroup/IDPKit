//
//  IDPKVOContext.h
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPKVOContext : NSObject

@property (nonatomic, assign)   NSObject                    *observer;
@property (nonatomic, copy)     NSString                    *keyPath;
@property (nonatomic, assign)   NSKeyValueObservingOptions  options;
@property (nonatomic, assign)   void                        *context;

+ (id)contextWithObserver:(NSObject *)observer
                  keyPath:(NSString *)keyPath
                  options:(NSKeyValueObservingOptions)options
                  context:(void *)context;

// returns yes, if observer, keypath and context are the same
- (BOOL)isEqual:(id)object;

// returns yes, if observer and keypath are the same
// discards context comparison
- (BOOL)isEqualToContext:(id)object;

@end
