//
//  NSBundle+NIBLoading.m
//  Phingo
//
//  Created by trimm on 27.07.11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import "NSBundle+IDPExtensions.h"


@implementation NSBundle (IDPExtensions)

+ (id)loadClass:(Class)theClass fromDefaultNibWithOwner:(id)theOwner {
	return [[NSBundle mainBundle] loadClass:theClass fromDefaultNibWithOwner:theOwner];
}

+ (id)loadClass:(Class)theClass fromNibNamed:(NSString *)theNibName owner:(id)theOwner {
	return [[NSBundle mainBundle] loadClass:theClass fromNibNamed:theNibName owner:theOwner];
}

+ (id)loadClass:(Class)theClass fromNibNamed:(NSString *)theNibName owner:(id)theOwner options:(NSDictionary *)options {
	return [[NSBundle mainBundle] loadClass:theClass fromNibNamed:theNibName owner:theOwner options:options];
}

+ (NSString *)pathForResource:(NSString *)name ofType:(NSString *)extension {
    return [[NSBundle mainBundle] pathForResource:name ofType:extension];
}

- (id)loadClass:(Class)theClass fromDefaultNibWithOwner:(id)theOwner {
	return [self loadClass:theClass fromNibNamed:NSStringFromClass(theClass) owner:theOwner options:nil];
}

- (id)loadClass:(Class)theClass fromNibNamed:(NSString *)theNibName owner:(id)theOwner {
	return [self loadClass:theClass fromNibNamed:theNibName owner:theOwner options:nil];
}

- (id)loadClass:(Class)theClass fromNibNamed:(NSString *)theNibName owner:(id)theOwner options:(NSDictionary *)options {
	NSArray *nibArray = [self loadNibNamed:theNibName
									 owner:theOwner
								   options:options];
	
	for (id object in nibArray) {
		if ([object isMemberOfClass:theClass]) {
			return [[object retain] autorelease];
		}
	}
	return nil;
}

@end
