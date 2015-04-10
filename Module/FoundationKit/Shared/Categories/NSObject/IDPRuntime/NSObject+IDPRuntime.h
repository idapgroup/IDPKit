//
//  NSObject+IDPRuntime.h
//  iOS
//
//  Created by Oleksa Korin on 4/9/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IDPRuntime)

+ (NSSet *)subclasses;

- (Class)isa;

@end
