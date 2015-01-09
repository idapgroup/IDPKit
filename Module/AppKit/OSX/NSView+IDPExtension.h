//
//  NSView+IDPExtension.h
//  MovieScript
//
//  Created by Artem Chabanniy on 12/09/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (IDPExtension)

@property (nonatomic, assign) CGFloat maxViewWidth;
@property (nonatomic, assign) CGFloat maxViewHeight;
@property (nonatomic, assign) CGFloat minViewWidth;
@property (nonatomic, assign) CGFloat minViewHeight;

/** Sets the background color of the receiver
 if the view is not backed by a layer, creates the layer.
 */
@property (nonatomic, retain) NSColor *backgroundColor;

/**
 The center of the frame. 
 The center is specified within the coordinate system of its superview and is measured in points.
 */
@property (nonatomic, assign) CGPoint center;

@end
