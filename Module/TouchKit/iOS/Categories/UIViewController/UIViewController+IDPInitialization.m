    //
//  UIViewController+Initialization.m
//  YouGotListings
//
//  Created by Oleksa Korin on 3/12/11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import "UIViewController+IDPInitialization.h"


@implementation UIViewController (IDPInitialization)

+ (id)newViewControllerWithDefaultNib {
	return [[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}

+ (id)viewControllerWithDefaultNib {
	return [[self newViewControllerWithDefaultNib] autorelease];
}

@end
