//
//  IDPMachTimer.h
//  iOSStreamingPlayer
//
//  Created by Denis Halabuzar on 4/27/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPMachTimer : NSObject

+ (id)timerWithName:(NSString *)name;

- (void)start;
- (void)stop;

@end
