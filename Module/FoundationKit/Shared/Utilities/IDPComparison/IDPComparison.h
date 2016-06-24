//
//  IDPComparison.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_STATIC_INLINE
NSUInteger NSUIntegerBitRotate(NSUInteger value, NSUInteger rotation) {
    if (!rotation) {
        return value;
    }
    
    NSUInteger bitCount = CHAR_BIT * sizeof(bitCount);
    rotation %= bitCount;
    
    return value << rotation | value >> (bitCount - rotation);
}
