//
//  IDPBlockMacros.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/4/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPUtilityMacros.h"

#define __IDPBlockCall(result, operation, block, ...) \
    do { \
        typeof(block) expression = block; \
        if (expression) { \
            result operation expression(__VA_ARGS__); \
        } \
    } while(0)

#define IDPBlockCall(...) __IDPBlockCall(IDPEmpty, IDPEmpty, __VA_ARGS__)

#define IDPResultBlockCall(result, ...) __IDPBlockCall(result, =, __VA_ARGS__)

#define IDPReturnBlockCall(...) __IDPBlockCall(IDPEmpty, return, __VA_ARGS__)
