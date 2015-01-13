//
//  NSDateComponents+IDPExtinsions.m
//  iOSAlarmClock
//
//  Created by Artem Chabanniy on 04/02/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSDateComponents+IDPExtensions.h"

@implementation NSDateComponents (IDPExtinsions)

- (NSDate *)createDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateFromComponents:self];
}

@end
