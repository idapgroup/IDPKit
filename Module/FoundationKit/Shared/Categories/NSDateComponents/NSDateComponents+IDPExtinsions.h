//
//  NSDateComponents+IDPExtinsions.h
//  iOSAlarmClock
//
//  Created by Artem Chabanniy on 04/02/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateComponents (IDPExtinsions)

- (NSTimeInterval)totalTimeInSeconds;
- (NSDate *)dateFromComponents;

@end
