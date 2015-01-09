//
//  NSManagedObjectID+Comparison.h
//  CoreData
//
//  Created by Oleksa Korin on 10/9/10.
//  Copyright 2010 RedShiftLab. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectID (IDPComparison)

- (BOOL)isEqualToId:(NSManagedObjectID *)theObjectID;

@end
