//
//  UIEvent+IDPExtensions.m
//  ClipIt
//
//  Created by Vadim Lavrov Viktorovich on 2/23/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "UIEvent+IDPExtensions.h"

@implementation UIEvent (IDPExtensions)

- (CGPoint)locationInView:(UIView *)view {
    UITouch *touch = [[self allTouches] anyObject];
    return [touch locationInView:view];
}

@end
