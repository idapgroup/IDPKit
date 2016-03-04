//
//  IDPReturnMacros.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/4/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#define IDPReturnValueIfNil(condition, value) \
    do { \
        if (!(condition)) { \
            return value; \
        } \
    } while(0)

#define IDPEmpty

#define IDPReturnNilIfNil(condition) IDPReturnValueIfNil((condition), nil)
#define IDPReturnIfNil(condition) IDPReturnValueIfNil((condition), IDPEmpty)
