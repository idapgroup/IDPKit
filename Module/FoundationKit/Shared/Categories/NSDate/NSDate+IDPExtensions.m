//
//  NSDate+RSLAdditions.m
//  BudgetJar
//
//  Created by Oleksa Korin on 4/27/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import "NSDate+IDPExtensions.h"

@implementation NSDate (IDPExtensions)

- (NSDateComponents *)dateComponents {
    return [self dateComponentsWithCalendar:[NSCalendar autoupdatingCurrentCalendar]];
}

- (NSDateComponents *)dateComponentsWithCalendar:(NSCalendar *)calendar {
    NSUInteger components = NSEraCalendarUnit
                            | NSYearCalendarUnit
                            | NSMonthCalendarUnit
                            | NSDayCalendarUnit
                            | NSHourCalendarUnit
                            | NSMinuteCalendarUnit
                            | NSSecondCalendarUnit
                            | NSWeekCalendarUnit
                            | NSWeekdayCalendarUnit
                            | NSWeekdayOrdinalCalendarUnit
                            | NSQuarterCalendarUnit
                            | NSWeekOfMonthCalendarUnit
                            | NSWeekOfYearCalendarUnit
                            | NSYearForWeekOfYearCalendarUnit
                            | NSCalendarCalendarUnit
                            | NSTimeZoneCalendarUnit;
    
    return [calendar components:components fromDate:self];
}

@end
