//
//  NSIndexPath+IDPExtensions.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSIndexPath+IDPExtensions.h"

@implementation NSIndexPath (IDPExtensions)

@dynamic index;

- (NSUInteger)index {
    return [self indexAtPosition:0];
}

@end
