//
//  IDPComparison.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

static
NSUInteger NSUIntegerBitRotate(NSUInteger value, NSUInteger rotation) {
    NSUInteger bitCount = CHAR_BIT * sizeof(bitCount);
    
    return value << rotation | value >> (bitCount - rotation);
}
