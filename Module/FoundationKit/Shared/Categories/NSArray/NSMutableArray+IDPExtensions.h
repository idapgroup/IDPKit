//
//  NSMutableArray+IDPExtensions.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/9/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (IDPExtensions)

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex;

@end
