//
//  IDPBlock.h
//  AudioStretcher
//
//  Created by Oleksa 'trimm' Korin on 3/12/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IDPDispatchQueueType) {
    IDPDispatchQueueHigh = DISPATCH_QUEUE_PRIORITY_HIGH,
    IDPDispatchQueueDefault = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    IDPDispatchQueueLow = DISPATCH_QUEUE_PRIORITY_LOW,
    IDPDispatchQueueBackground = DISPATCH_QUEUE_PRIORITY_BACKGROUND,
    IDPDispatchQueueMain
};

extern
void IDPDispatchOnMainQueue(BOOL synchronous, dispatch_block_t block);

extern
void IDPDispatchAsyncOnBackgroundQueue(dispatch_block_t block);

extern
void IDPDispatchAsyncOnQueue(IDPDispatchQueueType type, dispatch_block_t block);

extern
dispatch_queue_t IDPDispatchGetQueue(IDPDispatchQueueType type);