//
//  NSNib+NIBLoading.m
//  Phingo
//
//  Created by trimm on 27.07.11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import "UINib+IDPExtensions.h"

@implementation UINib (IDPExtensions)

+ (id)loadClass:(Class)theClass {
	return [self loadClass:theClass inBundle:[NSBundle mainBundle]];
}

+ (id)loadClass:(Class)theClass inBundle:(NSBundle *)theBundle {
	return [self loadClass:theClass 
			  fromNibNamed:NSStringFromClass(theClass) 
				  inBundle:theBundle];
}

+ (id)loadClass:(Class)theClass fromNibNamed:(NSString *)nibName inBundle:(NSBundle *)theBundle {
	UINib *nib = [UINib nibWithNibName:nibName bundle:theBundle];
	
	return [nib loadClass:theClass];
}

+ (id)loadClass:(Class)theClass withOwner:(id)theOwner {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(theClass) bundle:[NSBundle mainBundle]];
    return [nib loadClass:theClass withOwner:theOwner];
}

- (id)loadClass:(Class)theClass {
	return [self loadClass:theClass withOwner:nil];
}

- (id)loadClass:(Class)theClass withOwner:(id)theOwner {
	NSArray *result = [self instantiateWithOwner:theOwner options:nil];
	
	if (!result) {
		return nil;
	}
	
	for (id object in result) {
		if ([object isMemberOfClass:theClass]) {
			return [[object retain] autorelease];
		}
	}
	
	return nil;
}

@end
