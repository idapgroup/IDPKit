//
//  IDPWeakrefArray.h
//  AlarmClock
//
//  Extended by Oleksandr Korin on 04/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPWeakReference.h"
#import "IDPMutableArray.h"

// Array subclasses, that contain the IDPWeakReferenced objects

@interface IDPMutableWeakArray : IDPMutableArray

@property (nonatomic, readonly) NSArray *weakReferences;

@end
