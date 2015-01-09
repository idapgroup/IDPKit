//
//  UIView+IDPExtensions.m
//  ClipIt
//
//  Created by Oleksa 'trimm' Korin on 2/24/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "UIView+IDPExtensions.h"

#import "UINib+IDPExtensions.h"

@implementation UIView (IDPExtensions)

- (CGRect)intersectionWithView:(UIView *)theView {
    if (self.window != theView.window || nil == self.window) {
        return CGRectNull;
    }
    
    CGRect viewRect = [[theView superview] convertRect:theView.frame toView:nil];
    CGRect currentRect = [[self superview] convertRect:self.frame toView:nil];
    
    return CGRectIntersection(viewRect, currentRect);
}

- (void)substitutePlaceholderView:(UIView *)placeholderView
                         withView:(UIView *)view
{
    placeholderView.frame = view.frame;
    [view removeFromSuperview];
    [self addSubview:placeholderView];
}

- (void)substitutePlaceholderView:(UIView *)placeholderView
                    withViewClass:(Class)viewClass
{
    [self substitutePlaceholderView:placeholderView
                      withViewClass:viewClass nibName:NSStringFromClass(viewClass)];
}

- (void)substitutePlaceholderView:(UIView *)placeholderView
                    withViewClass:(Class)viewClass
                          nibName:(NSString *)nibName
{
    [self substitutePlaceholderView:placeholderView
                      withViewClass:viewClass
                            nibName:nibName
                           inBundle:nil];
}

- (void)substitutePlaceholderView:(UIView *)placeholderView
                    withViewClass:(Class)viewClass
                          nibName:(NSString *)nibName
                         inBundle:(NSBundle *)bundle
{
    UIView *view = [UINib loadClass:viewClass
                       fromNibNamed:nibName
                           inBundle:bundle];
    
    [self substitutePlaceholderView:placeholderView withView:view];
}

@end
