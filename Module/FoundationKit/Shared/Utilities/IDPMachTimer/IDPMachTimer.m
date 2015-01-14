//
//  IDPMachTimer.m
//  iOSStreamingPlayer
//
//  Created by Denis Halabuzar on 4/27/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMachTimer.h"
#include <mach/mach_time.h>

static inline
long double IDPMachTimeToSeconds(UInt64 machTime) {
    const int64_t kOneMillion = 1000 * 1000 * 1000;
    static mach_timebase_info_data_t s_timebase_info;
    
    if (s_timebase_info.denom == 0) {
        mach_timebase_info(&s_timebase_info);
    }
    
    // mach_absolute_time() returns billionth of seconds,
    // so divide by one million to get milliseconds
    return (long double)(machTime * s_timebase_info.numer)
            / (long double)(kOneMillion * s_timebase_info.denom);
}

@interface IDPMachTimer ()
@property (nonatomic, assign)   UInt64      startTime;
@property (nonatomic, assign)   long double duration;

@property (nonatomic, assign, getter = isMeasuring)   BOOL measuring;

@end

@implementation IDPMachTimer

@dynamic duration;

#pragma mark -
#pragma mark Overriden Methods

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ duration = %Lf",
            [super description],
            self.duration];
}

#pragma mark -
#pragma mark Public Methods

- (void)start {
    if (self.measuring) {
        return;
    }
    
    self.startTime = mach_absolute_time();
    self.duration = 0;
    self.measuring = YES;
}

- (void)stop {
    if (!self.measuring) {
        return;
    }
    
    self.duration = IDPMachTimeToSeconds(mach_absolute_time() - self.startTime);
    self.measuring = NO;
}

@end
