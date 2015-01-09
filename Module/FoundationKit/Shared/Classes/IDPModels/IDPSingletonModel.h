//
//  IDPSingletonModel.h
//  MovieScript
//
//  Created by Artem Chabanniy on 10/09/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPModel.h"

/* You have to implement following method in your subclass:
 
 + (id)__sharedObject {
    return __yourUniqueIdentifier;
 }
 
 + (id)sharedObject {
    static dispatch_once_t __yourUniqueOnceToken;
    dispatch_once(&__yourUniqueOnceToken, ^{
    __yourUniqueIdentifier = [[self alloc] init];
    });
 
    return __yourUniqueIdentifier;
 }
 
 */

@interface IDPSingletonModel : IDPModel

+ (id)sharedObject;

@end
