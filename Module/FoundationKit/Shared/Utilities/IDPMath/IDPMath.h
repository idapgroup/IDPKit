//
//  IDPMath.h
//  AnotherTossGame
//
//  Created by Artem Chabanniy on 17/10/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(degrees) ((degrees) * (M_PI / 180))

/**
 Generate a random number in range min and max - 1.
 @param min
        The min digit in range.
 @param max
        The max digit in range.
 @return Digit in range from min to (max-1).
 */
NSInteger IDPRandomNumberInRange(NSInteger min, NSInteger max);
