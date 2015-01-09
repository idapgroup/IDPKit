//
//  NSDate+RSLAdditions.h
//  BudgetJar
//
//  Created by Oleksa Korin on 4/27/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>

static  NSString *const IDPDateTimeFormateString  =   @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'";

@interface NSDate (IDPExtensions)

+ (NSInteger)numberOfDaysInCurrentMonth;
+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)date;

+ (NSInteger)numberOfDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSDate *)day:(NSInteger)day ofMonthForDate:(NSDate *)date;
+ (NSDate *)lastDayOfMonthForDate:(NSDate *)date;

+ (NSDate *)dayOfCurrentMonth:(NSInteger)day;
+ (NSDate *)lastDayOfCurrentMonth;

+ (NSDate *)midnightDateForDate:(NSDate *)date;

+ (NSDate *)dateByAddingDays:(NSInteger)days toDate:(NSDate *)date;

+ (NSString *)weekdayAtDay:(NSInteger)day;
+ (NSInteger)dayOfWeek:(NSString *)day;

+ (NSDate *)dateFromString:(NSString *)dateString withStringFormate:(NSString *)stringFromate;
- (NSString *)dateToStringWithFormat:(NSString *)stringFromate;

- (NSDateComponents *)components:(NSUInteger)unitFlags;

- (NSInteger)numberOfDaysToDate:(NSDate *)toDate;

- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)midnightDate;

- (NSInteger)day;
- (NSString *)weekday;
- (NSInteger)dayOfWeek;

@end
