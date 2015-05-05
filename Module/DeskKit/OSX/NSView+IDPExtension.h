//
//  NSView+IDPExtension.h
//  MovieScript
//
//  Created by Artem Chabanniy on 12/09/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

IB_DESIGNABLE
@interface NSView (IDPExtension)

@property (nonatomic, assign) IBInspectable CGFloat maxViewWidth;
@property (nonatomic, assign) IBInspectable CGFloat maxViewHeight;
@property (nonatomic, assign) IBInspectable CGFloat minViewWidth;
@property (nonatomic, assign) IBInspectable CGFloat minViewHeight;

/** Sets the background color of the receiver
 if the view is not backed by a layer, creates the layer.
 */
@property (nonatomic, strong) IBInspectable NSColor *backgroundColor;

/**
 The center of the frame. 
 The center is specified within the coordinate system of its superview and is measured in points.
 */
@property (nonatomic, assign) CGPoint center;

/**
 Sets the corner radius of the receiver
 if the view is not backed by a layer, creates the layer.
 */

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 Sets the border width of the receiver
 if the view is not backed by a layer, creates the layer.
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/**
 Sets the border color of the receiver
 if the view is not backed by a layer, creates the layer.
 */
@property (nonatomic, strong) IBInspectable NSColor *borderColor;

@end
