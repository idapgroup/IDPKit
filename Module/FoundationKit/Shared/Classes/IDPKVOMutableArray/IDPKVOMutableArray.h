//
//  IDPKVOMutableArray.h
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kIDPKVOPathCount;

// A proxy object used, when KVO is needed
// if you want to KVO to work, observe the key @"count",
// but modify the array only through the methods of IDPMutableArray

@interface IDPKVOMutableArray : NSObject

// creates array
+ (NSMutableArray *)array;

// if you pass nil works the same, as creating + (NSMutableArray *)array
+ (NSMutableArray *)arrayWithArray:(NSArray *)array;

@end