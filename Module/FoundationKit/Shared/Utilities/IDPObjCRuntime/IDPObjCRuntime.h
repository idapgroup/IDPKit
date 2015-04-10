//
//  IDPObjCRuntime.h
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPTypes.h"

#define IDPStringFromSEL(value) NSStringFromSelector(@selector(value))

#define __assign __unsafe_unretained

// It should return YES, if the enumeration should continue
typedef BOOL (^IDPClassEnumerationBlock)(__assign Class cls);

extern
NSString *IDPKVONameOfClass(__assign Class cls);

extern
void IDPEnumerateClassHierarchy(__assign Class cls, IDPClassEnumerationBlock block);

extern
BOOL IDPClassConformsToProtocol(__assign Class cls, Protocol *protocol);

// Returns YES, if the cls itself responds to selector
extern
BOOL IDPClassRespondsToSelector(__assign Class cls, SEL selector);

extern
BOOL IDPClassInstancesRespondToSelector(__assign Class cls, SEL selector);

extern
Class IDPMetaClassOfClass(__assign Class cls);

extern
NSSet *IDPClassSet();

extern
NSSet *IDPSubclassesOfClassSet(__assign Class cls);
