//
//  CGGeometry+IDPExtensions.m
//  CommonKit
//
//  Created by Oleksa 'trimm' Korin on 5/21/12.
//  Copyright (c) 2012 IDAP Group. All rights reserved.
//

#import "CGGeometry+IDPExtensions.h"

#pragma mark -
#pragma mark Comparison

NSComparisonResult CGPointCompareToPoint(CGPoint src, CGPoint dst) {
	NSComparisonResult result = (CGPointCompareToPointByY(src, dst));
	
	if (result != NSOrderedSame) {
		return result;
	}
	
	return CGPointCompareToPointByX(src, dst);
}

NSComparisonResult CGPointCompareToPointByX(CGPoint src, CGPoint dst) {
	if (src.x < dst.x) {
		return NSOrderedAscending;
	} else if (src.x > dst.x) {
		return NSOrderedDescending;
	}
	
	return NSOrderedSame;
}

NSComparisonResult CGPointCompareToPointByY(CGPoint src, CGPoint dst) {
	if (src.y < dst.y) {
		return NSOrderedAscending;
	} else if (src.y > dst.y) {
		return NSOrderedDescending;
	}
	
	return NSOrderedSame;
}

#pragma mark -
#pragma mark Affine Transforms

CGAffineTransform CGAffineTransformAddTranslation(CGAffineTransform t, CGFloat tx, CGFloat ty) {
    CGAffineTransform translation = CGAffineTransformMakeTranslation(tx, ty);
    
    return CGAffineTransformConcat(t, translation);
}

CGAffineTransform CGAffineTransformAddRotation(CGAffineTransform t, CGFloat angle) {
    CGAffineTransform rotation = CGAffineTransformMakeRotation(angle);
    
    return CGAffineTransformConcat(t, rotation);
}

CGAffineTransform CGAffineTransformAddScale(CGAffineTransform t, CGFloat sx, CGFloat sy) {
    CGAffineTransform scale = CGAffineTransformMakeScale(sx, sy);
    
    return CGAffineTransformConcat(t, scale);
}

static CGPoint CGPointForFlipDirection(IDPFlipDirection direction) {
    CGPoint scale = CGPointMake(1.0f, 1.0f);
    if (IDPVerticalFlip == direction) {
        scale.y = -1.0f;
    } else if (IDPHorizontalFlip == direction) {
        scale.x = -1.0f;
    }
    
    return scale;
}

CGAffineTransform CGAffineTransformMakeFlip(IDPFlipDirection direction) {
    CGPoint scale = CGPointForFlipDirection(direction);
    
    return CGAffineTransformMakeScale(scale.x, scale.y);
}

CGAffineTransform CGAffineTransformAddFlip(CGAffineTransform t, IDPFlipDirection direction) {
    CGPoint scale = CGPointForFlipDirection(direction);
    
    return CGAffineTransformAddScale(t, scale.x, scale.y);
}

#pragma mark -
#pragma mark Origin Affine Transforms

CGAffineTransform CGOriginAffineTransformWithBlock(CGPoint center, IDPAffineTransformBlock block) {
    CGAffineTransform t = CGAffineTransformIdentity;
    
    t = CGAffineTransformAddTranslation(t, -center.x, -center.y);
    t = CGAffineTransformConcat(t, block());
    t = CGAffineTransformAddTranslation(t, center.x, center.y);
    
    return t;
}

CGAffineTransform CGOriginAffineTransformRotate(CGPoint center, CGFloat angle) {
    return CGOriginAffineTransformWithBlock(center, ^CGAffineTransform() {
        return CGAffineTransformMakeRotation(angle);
    });
}

CGAffineTransform CGOriginAffineTransformScale(CGPoint center, CGFloat sx, CGFloat sy) {
    return CGOriginAffineTransformWithBlock(center, ^CGAffineTransform() {
        return CGAffineTransformMakeScale(sx, sy);
    });
}

CGAffineTransform CGOriginAffineTransformFlip(CGPoint center, IDPFlipDirection direction) {
    return CGOriginAffineTransformWithBlock(center, ^CGAffineTransform() {
        return CGAffineTransformMakeFlip(direction);
    });
}

#pragma mark -
#pragma mark Origin Affine Transform Adding

CGAffineTransform CGOriginAffineTransformAddRotation(CGAffineTransform t,
                                                    CGPoint center,
                                                    CGFloat angle)
{
    CGAffineTransform transform = CGOriginAffineTransformRotate(center, angle);
    return CGAffineTransformConcat(t, transform);
}

CGAffineTransform CGOriginAffineTransformAddScale(CGAffineTransform t,
                                                 CGPoint center,
                                                 CGFloat sx,
                                                 CGFloat sy)
{
    CGAffineTransform transform = CGOriginAffineTransformScale(center, sx, sy);
    return CGAffineTransformConcat(t, transform);
}

CGAffineTransform CGOriginAffineTransformAddFlip(CGAffineTransform t,
                                                CGPoint center,
                                                IDPFlipDirection direction)
{
    CGAffineTransform transform = CGOriginAffineTransformFlip(center, direction);
    return CGAffineTransformConcat(t, transform);
}
