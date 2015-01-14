//
//  NSDate+RSLAdditions.h
//  BudgetJar
//
//  Created by Oleksa Korin on 4/27/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (IDPExtensions)

- (NSDateComponents *)dateComponents;
- (NSDateComponents *)dateComponentsWithCalendar:(NSCalendar *)calendar;

@end
