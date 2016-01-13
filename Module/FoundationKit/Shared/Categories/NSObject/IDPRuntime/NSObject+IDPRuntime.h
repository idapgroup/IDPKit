//
//  NSObject+IDPRuntime.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/13/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^IDPBlockWithIMP)(IMP implementation);

@interface NSObject (IDPRuntime)

+ (void)setBlock:(IDPBlockWithIMP)block forSelector:(SEL)selector;

@end
