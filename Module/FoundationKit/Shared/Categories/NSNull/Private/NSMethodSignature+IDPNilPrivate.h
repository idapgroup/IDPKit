//
//  NSMethodSignature+IDPNilPrivate.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/13/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMethodSignature (IDPNilPrivate)
@property (nonatomic, assign, getter=isNilForwarded)    BOOL nilForwarded;

@end
