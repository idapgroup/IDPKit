//
//  IDPOwnershipMacros.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/7/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPCompilerMacros.h"
#import "IDPUtilityMacros.h"
#import "IDPReturnMacros.h"

#define IDPWeakify(variable) \
    __weak __typeof(variable) __IDPWeakified_##variable = variable

// you should only call this method after you called weakify for that same variable
#define IDPStrongify(variable) \
    IDPClangDiagnosticPushExpression("clang diagnostic ignored \"-Wshadow\"") \
    __strong __typeof(variable) variable = __IDPWeakified_##variable \
    IDPClangDiagnosticPopExpression

#define IDPStrongifyAndReturnValueIfNil(variable, value) \
    IDPStrongify(variable); \
    IDPReturnValueIfNil(variable, value)

#define IDPStrongifyAndReturnIfNil(variable) \
    IDPStrongifyAndReturnValueIfNil(variable, IDPEmpty)

#define IDPStrongifyAndReturnNilIfNil(variable) \
    IDPStrongifyAndReturnValueIfNil(variable, nil)
