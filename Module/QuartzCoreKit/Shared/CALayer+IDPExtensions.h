//
//  CALayer+RoundedCorners.h
//  blockTest
//
//  Created by Vadim Lavrov Viktorovich on 7/8/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (IDPExtensions)

// pass the result of the method to the view's layer's
// mask and this will round view's corners separately

+ (CALayer *)roundCorneredLayerForBounds:(CGRect)rect
                       withTopLeftRadius:(CGFloat)topLeft
                      withTopRightRadius:(CGFloat)topRight
                    withBottomLeftRadius:(CGFloat)bottomLeft
                   withBottomRightRadius:(CGFloat)bottomRight;



@end
