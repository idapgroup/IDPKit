//
//  NSManagedObjectID+Comparison.m
//  CoreData
//
//  Created by Oleksa Korin on 10/9/10.
//  Copyright 2010 RedShiftLab. All rights reserved.
//

#import "NSManagedObjectID+IDPExtensions.h"

@implementation NSManagedObjectID (IDPComparison)

- (BOOL)isEqualToId:(NSManagedObjectID *)theObjectID {
	return [[self URIRepresentation] isEqual:[theObjectID URIRepresentation]];
}

@end
