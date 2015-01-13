//
//  IDPMachTimer.m
//  iOSStreamingPlayer
//
//  Created by Denis Halabuzar on 4/27/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMachTimer.h"
#include <mach/mach_time.h>

static inline double IDPMachTimeToMilliseconds(UInt64 machTime) {
    const int64_t kOneMillion = 1000 * 1000;
    static mach_timebase_info_data_t s_timebase_info;
    
    if (s_timebase_info.denom == 0) {
        mach_timebase_info(&s_timebase_info);
    }
    
    // mach_absolute_time() returns billionth of seconds,
    // so divide by one million to get milliseconds
    return (int)((machTime * s_timebase_info.numer) / (double)(kOneMillion * s_timebase_info.denom));
}

@interface IDPMachTimer ()

@property (nonatomic, assign)   UInt64      testCount;
@property (nonatomic, assign)   UInt64      testSumm;
@property (nonatomic, assign)   UInt64      enterTime;
@property (nonatomic, copy)     NSString    *name;

@end

@implementation IDPMachTimer

@synthesize testCount   = _testCount;
@synthesize testSumm    = _testSumm;
@synthesize enterTime   = _enterTime;
@synthesize name        = _name;

#pragma mark -
#pragma mark Class Methods

+ (id)timerWithName:(NSString *)name {
    IDPMachTimer *timer = [self new];
    if (timer) {
        timer.name = name;
    }

    return timer;
}

#pragma mark -
#pragma mark Overriden Methods

- (NSString *)description {
    return [NSString stringWithFormat:@"timer '%@'. test count %llu avg %f\n",
            self.name,
            self.testCount,
            IDPMachTimeToMilliseconds(self.testSumm ? self.testSumm/self.testCount : 0)];
}

#pragma mark -
#pragma mark Public Methods

- (void)start {
    self.enterTime = mach_absolute_time();
}

- (void)stop {
    ++self.testCount;
    self.testSumm += (mach_absolute_time() - self.enterTime);
}

@end
