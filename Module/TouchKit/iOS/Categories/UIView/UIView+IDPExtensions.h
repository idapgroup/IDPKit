//
//  UIView+IDPExtensions.h
//  ClipIt
//
//  Created by Oleksa 'trimm' Korin on 2/24/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IDPExtensions)

// Returns intersection rect of two views in window coordinates.
// If the views don't intersect or are notin the same window returns CGRectNull
- (CGRect)intersectionWithView:(UIView *)theView;

- (void)substitutePlaceholderView:(UIView *)placeholderView
                         withView:(UIView *)view;

- (void)substitutePlaceholderView:(UIView *)placeholderView
                    withViewClass:(Class)viewClass;

- (void)substitutePlaceholderView:(UIView *)placeholderView
                    withViewClass:(Class)viewClass
                          nibName:(NSString *)nibName;

- (void)substitutePlaceholderView:(UIView *)placeholderView
                    withViewClass:(Class)viewClass
                          nibName:(NSString *)nibName
                         inBundle:(NSBundle *)bundle;

@end
