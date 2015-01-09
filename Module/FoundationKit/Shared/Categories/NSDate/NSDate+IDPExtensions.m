//
//  NSDate+RSLAdditions.m
//  BudgetJar
//
//  Created by Oleksa Korin on 4/27/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import "NSDate+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"

@implementation NSDate (IDPExtensions)

+ (NSInteger)numberOfDaysInCurrentMonth {
	NSDate *today = [NSDate date]; //Get a date object for today's date
	return [self numberOfDaysInMonthForDate:today];
}

+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)date {
	NSCalendar *c = [NSCalendar currentCalendar];
	NSRange days = [c rangeOfUnit:NSDayCalendarUnit 
						   inUnit:NSMonthCalendarUnit 
						  forDate:date];
	
	return days.length;
}

+ (NSInteger)numberOfDaysFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
	NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
											   fromDate:fromDate 
												 toDate:toDate 
												options:0];
	
    return [difference day];	
}

+ (NSDate *)day:(NSInteger)day ofMonthForDate:(NSDate *)date {
	NSDateComponents *comps = [date components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)];	
	
	comps.day = day;
	
	return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+ (NSDate *)lastDayOfMonthForDate:(NSDate *)date {
	NSInteger days = [NSDate numberOfDaysInMonthForDate:date];
	return [NSDate day:days ofMonthForDate:date];
}

+ (NSDate *)dayOfCurrentMonth:(NSInteger)day {
	return [self day:day ofMonthForDate:[NSDate date]];
}

+ (NSDate *)lastDayOfCurrentMonth {
	NSInteger days = [NSDate numberOfDaysInCurrentMonth];
	return [NSDate dayOfCurrentMonth:days];
}

+ (NSDate *)midnightDateForDate:(NSDate *)date {
	NSDateComponents *comps = [date components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)];	
	
	return [[NSCalendar currentCalendar] dateFromComponents:comps];

}

+ (NSDate *)dateByAddingDays:(NSInteger)days toDate:(NSDate *)date {
	NSDateComponents *comps = [NSDateComponents object];
	
	comps.day = days;
	
	return [[NSCalendar currentCalendar] dateByAddingComponents:comps 
														 toDate:date 
														options:0];
}

+ (NSString *)weekdayAtDay:(NSInteger)day {
    NSString *weekday = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    
    weekday = [formatter.weekdaySymbols objectAtIndex:day - 1];
    
    [formatter release];
    return weekday;
}

+ (NSInteger)dayOfWeek:(NSString *)day {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.locale = [NSLocale currentLocale];
    
    return [formatter.weekdaySymbols indexOfObject:day] + 1;
}

+ (NSDate *)dateFromString:(NSString *)dateString withStringFormate:(NSString *)stringFromate {
    NSDate *date = nil;
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSLocale *locate = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB_POSIX"] autorelease];
    
    [formatter setLocale:locate];
    [formatter setDateFormat:stringFromate];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Convert the RFC 3339 date time string to an NSDate.
    date = [formatter dateFromString:dateString];
    
    return date;
}

- (NSString *)dateToStringWithFormat:(NSString *)stringFromate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSLocale *locate = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB_POSIX"] autorelease];
    
    [formatter setLocale:locate];
    [formatter setDateFormat:stringFromate];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [formatter stringFromDate:self];
}

- (NSDateComponents *)components:(NSUInteger)unitFlags {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	return [calendar components:unitFlags 
					   fromDate:self];
}

- (NSInteger)numberOfDaysToDate:(NSDate *)toDate {
	return [[self class] numberOfDaysFromDate:self toDate:toDate];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
	return [[self class] dateByAddingDays:days toDate:self];
}

- (NSDate *)midnightDate {
	return [[self class] midnightDateForDate:self];
}

- (NSInteger)day {
    NSUInteger flags = NSDayCalendarUnit;
    NSDateComponents *components = [self components:flags];
    return components.day;
}

- (NSString *)weekday {
    NSString *weekday = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    NSDateComponents *components = [self components:NSWeekdayCalendarUnit];
    
    weekday = [formatter.weekdaySymbols objectAtIndex:(components.weekday-1)];
    
    [formatter release];
    return weekday;
}

- (NSInteger)dayOfWeek {
    NSUInteger flags = NSWeekdayCalendarUnit;
    NSDateComponents *components = [self components:flags];
    return components.weekday;
}

@end
