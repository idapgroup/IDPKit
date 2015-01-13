//
//  IDPBlock.m
//  AudioStretcher
//
//  Created by Oleksa 'trimm' Korin on 3/12/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPDispatch.h"

void IDPDispatchOnMainQueue(BOOL synchronous, dispatch_block_t block) {
    dispatch_queue_t queue = IDPDispatchGetQueue(IDPDispatchQueueMain);

    if (synchronous) {
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_sync(queue, block);
        }
    } else {
        dispatch_async(queue, block);
    }
}

void IDPDispatchAsyncOnBackgroundQueue(dispatch_block_t block) {
    return IDPDispatchAsyncOnQueue(IDPDispatchQueueBackground, block);
}

void IDPDispatchAsyncOnQueue(IDPDispatchQueueType type, dispatch_block_t block) {
    dispatch_queue_t queue = IDPDispatchGetQueue(type);
    
    dispatch_async(queue, block);
}

dispatch_queue_t IDPDispatchGetQueue(IDPDispatchQueueType type) {
    if (IDPDispatchQueueMain == type) {
        return dispatch_get_main_queue();
    }
    
    return dispatch_get_global_queue(type, 0);
}
