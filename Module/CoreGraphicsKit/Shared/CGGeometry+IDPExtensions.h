//
//  CGGeometry+IDPExtensions.h
//  CommonKit
//
//  Created by Oleksa 'trimm' Korin on 5/21/12.
//  Copyright (c) 2012 IDAP Group. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

#pragma mark -
#pragma mark Cocoa Macros

#define CGWidth(rect) CGRectGetWidth(rect)
#define CGHeight(rect) CGRectGetHeight(rect)
#define CGMaxX(rect) CGRectGetMaxX(rect)
#define CGMaxY(rect) CGRectGetMaxY(rect)
#define CGMidX(rect) CGRectGetMidX(rect)
#define CGMidY(rect) CGRectGetMidY(rect)
#define CGMinX(rect) CGRectGetMinX(rect)
#define CGMinY(rect) CGRectGetMinY(rect)
#define CGCenter(rect) CGRectGetCenter(rect)

#pragma mark -
#pragma mark Maths

CG_INLINE
CGRect CGRectWithSize(CGSize size) {
	return CGRectMake(0, 0, size.width, size.height);
}

CG_INLINE
CGRect CGZeroOriginRectWithRect(CGRect rect) {
	return CGRectMake(0, 0, CGWidth(rect), CGHeight(rect));
}

CG_INLINE
CGFloat CGFloatMakeEven(CGFloat value) {
	NSInteger intValue = (NSInteger)roundf(value);
	if (intValue % 2 != 0) {
		intValue -= 1;
	}
	
	return (CGFloat)intValue;
}

CG_INLINE
CGFloat CGDistance(CGPoint point1, CGPoint point2) {
    float dx = point1.x - point2.x;
    float dy = point1.y - point2.y;
    return sqrt(dx*dx + dy*dy);
}

CG_INLINE
CGPoint CGRectGetCenter(CGRect rect) {
    return CGPointMake(CGMidX(rect), CGMidY(rect));
}

#pragma mark -
#pragma mark Comparison

CG_INLINE
BOOL CGFloatInRange(CGFloat value, CGFloat minBound, CGFloat maxBound) {
    return value >= minBound && value <= maxBound;
}

CG_INLINE
BOOL CGFloatEqualToFloatWithTolerance(CGFloat value1, CGFloat value2, CGFloat tolerance) {
    return ABS(value1 - value2) <= tolerance;
}

// comparison precedency: y axis, x axis
CG_EXTERN
NSComparisonResult CGPointCompareToPoint(CGPoint src, CGPoint dst);

CG_EXTERN
NSComparisonResult CGPointCompareToPointByX(CGPoint src, CGPoint dst);

CG_EXTERN
NSComparisonResult CGPointCompareToPointByY(CGPoint src, CGPoint dst);

#pragma mark -
#pragma mark Affine Transforms

typedef enum {
    IDPNoFlip,
    IDPVerticalFlip,
    IDPHorizontalFlip
} IDPFlipDirection;


// This method concats the transform |t|, with translation transform by |tx| in x axis and
// |ty| in y axis
CG_EXTERN
CGAffineTransform CGAffineTransformAddTranslation(CGAffineTransform t, CGFloat tx, CGFloat ty);

// This method concats the transform |t|, with |angle| rotation transform
CG_EXTERN
CGAffineTransform CGAffineTransformAddRotation(CGAffineTransform t, CGFloat angle);

// This method concats the transform |t|, with scale transform by |sx| in x axis and
// |sy| in y axis
CG_EXTERN
CGAffineTransform CGAffineTransformAddScale(CGAffineTransform t, CGFloat sx, CGFloat sy);

// This method creates the scale transform flipping either the vertical
// (scale = {1, -1}) or horizontal axis (scale = {-1, 1})
CG_EXTERN
CGAffineTransform CGAffineTransformMakeFlip(IDPFlipDirection direction);

// This method concats the transform |t|, with scale transform flipping either the vertical
// (scale = {1, -1}) or horizontal axis (scale = {-1, 1})
CG_EXTERN
CGAffineTransform CGAffineTransformAddFlip(CGAffineTransform t, IDPFlipDirection direction);

#pragma mark -
#pragma mark Origin Affine Transforms

// block, that applies, that returns the new transform
typedef CGAffineTransform (^IDPAffineTransformBlock)();

// This method is used to perform |origin| coordinate centric transforms, such as rotations.
// Creates the translation transform, that alignes |rect| origin with xy axis center,
// concats it with the |block| return value and then performs the inverse translation
// Warning: Never use the CGOriginAffineTransform function family inside the |block|
CG_EXTERN
CGAffineTransform CGOriginAffineTransformWithBlock(CGPoint origin, IDPAffineTransformBlock block);

// This method creates the transform, that rotates by |angle| around the |origin| point
CG_EXTERN
CGAffineTransform CGOriginAffineTransformRotate(CGPoint origin, CGFloat angle);

// This method creates the transform, that scales by |sx| in x axis and
// |sy| in y axis around the |origin| point
CG_EXTERN
CGAffineTransform CGOriginAffineTransformScale(CGPoint origin, CGFloat sx, CGFloat sy);

// This method creates the transform, that flips the in |direction| around the |origin| point
CG_EXTERN
CGAffineTransform CGOriginAffineTransformFlip(CGPoint origin, IDPFlipDirection direction);

#pragma mark -
#pragma mark Origin Affine Transform Adding

// This method creates the transform, that rotates by |angle| around the |origin| point
// and concats transform |t| with it
CG_EXTERN
CGAffineTransform CGOriginAffineTransformAddRotation(CGAffineTransform t,
                                                    CGPoint origin,
                                                    CGFloat angle);

// This method creates the transform, that scales by |sx| in x axis and
// |sy| in y axis around the |origin| point and concats transform |t| with it
CG_EXTERN
CGAffineTransform CGOriginAffineTransformAddScale(CGAffineTransform t,
                                                 CGPoint origin,
                                                 CGFloat sx,
                                                 CGFloat sy);

// This method creates the transform, that flips the in |direction| around the |origin| point
// and concats transform |t| with it
CG_EXTERN
CGAffineTransform CGOriginAffineTransformAddFlip(CGAffineTransform t,
                                                CGPoint origin,
                                                IDPFlipDirection direction);
