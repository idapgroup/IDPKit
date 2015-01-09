//
//  NSDateComponents+IDPExtinsions.m
//  iOSAlarmClock
//
//  Created by Artem Chabanniy on 04/02/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSDateComponents+IDPExtinsions.h"

@implementation NSDateComponents (IDPExtinsions)

- (NSTimeInterval)totalTimeInSeconds {
    NSTimeInterval timeInterval = 0;
    
    if (self.hour != 0) {
        timeInterval += self.hour * 60 * 60;
    }
    if (self.minute != 0) {
        timeInterval += self.minute * 60;
    }
    if (self.second != 0) {
        timeInterval += self.second;
    }
    
    return timeInterval;
}

- (NSDate *)dateFromComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateFromComponents:self];
}

@end
