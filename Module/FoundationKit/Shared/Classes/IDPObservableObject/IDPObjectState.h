//
//  IDPObjectState.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/3/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __IDPObjectState(name, startName, start, ...) \
    typedef enum { \
        start, \
        __VA_ARGS__, \
        name##End, \
        name##Count = name##End - startName - 1 \
    } name

#define IDPObjectState(name, ...) __IDPObjectState(name, name##Undefined, name##Undefined, __VA_ARGS__)

#define IDPObjectStateChild(name, parent, ...) __IDPObjectState(name, name##Start, name##Start = parent##End - 1, __VA_ARGS__)
