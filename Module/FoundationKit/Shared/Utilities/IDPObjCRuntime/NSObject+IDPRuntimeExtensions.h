//
//  NSObject+IDPRuntimeExtensions.h
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IDPRuntimeExtensions)

+ (Class)KVOClass;

- (Class)isa;
- (Class)KVOClass;

@end
