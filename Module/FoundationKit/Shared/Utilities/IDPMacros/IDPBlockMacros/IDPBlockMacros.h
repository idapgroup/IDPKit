//
//  IDPBlockMacros.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/4/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __IDPBlockCall(block, ...) \
    do { \
        typeof(block) expression = block; \
        if (expression) { \
            expression(__VA_ARGS__); \
        } \
    } while(0)

#define IDPBlockCall(...) __IDPBlockCall(__VA_ARGS__)
