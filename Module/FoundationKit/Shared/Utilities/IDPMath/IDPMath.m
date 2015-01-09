//
//  IDPMath.m
//  AnotherTossGame
//
//  Created by Artem Chabanniy on 17/10/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMath.h"

NSInteger IDPRandomNumberInRange(NSInteger min, NSInteger max) {
    return arc4random_uniform(max - min) + min;
}
