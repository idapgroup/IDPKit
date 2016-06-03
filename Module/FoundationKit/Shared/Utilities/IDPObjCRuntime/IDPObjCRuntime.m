//
//  NSObject+IDPKVOPrivate.h
//  iOS
//
//  Created by Oleksa Korin on 30/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPObjCRuntime.h"

#import <objc/runtime.h>

NSString *IDPKVONameOfClass(__assign Class class) {
    return [NSString stringWithFormat:@"NSKVONotifying_%@", NSStringFromClass(class)];
}

void IDPEnumerateClassHierarchy(__assign Class class, IDPClassEnumerationBlock block) {
    BOOL shouldContinue = YES;
    
    do {
        shouldContinue = block(class);
        class = class_getSuperclass(class);
    } while (shouldContinue && Nil != class);
}

BOOL IDPClassConformsToProtocol(__assign Class class, Protocol *protocol) {
    __block BOOL result = NO;
    IDPEnumerateClassHierarchy(class, ^(__assign Class hierarchyClass) {
        result = class_conformsToProtocol(hierarchyClass, protocol);
        
        return (BOOL)!result;
    });
    
    return result;
}

BOOL IDPClassRespondsToSelector(__assign Class class, SEL selector) {
    __assign Class metaClass = IDPMetaClassOfClass(class);
    
    return class_respondsToSelector(metaClass, selector);
}

BOOL IDPClassInstancesRespondToSelector(__assign Class class, SEL selector) {
    return class_respondsToSelector(class, selector);
}

Class IDPMetaClassOfClass(__assign Class class) {
    return object_getClass(class);
}

NSSet *IDPClassSet() {
    NSMutableSet *result = [NSMutableSet new];
    
    unsigned int count = 0;
    __unsafe_unretained id class = nil;
    Class *classes = objc_copyClassList(&count);
    Protocol *protocol = objc_getProtocol([NSStringFromClass([NSObject class]) UTF8String]);
    
    
    if (count > 0) {
        for (NSUInteger index = 0; index < count; index++) {
            class = classes[index];
            
            if (IDPClassConformsToProtocol(class, protocol)) {
                [result addObject:class];
            }
        }
    }
    
    if (NULL != classes) {
        free(classes);
    }

    return (0 != count) ? [result copy] : nil;
}

NSSet *IDPSubclassesOfClassSet(__assign Class class) {
    NSSet *classes = IDPClassSet();

    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(__assign Class evaluatedClass, NSDictionary *bindings) {
        if (class != evaluatedClass
            && IDPClassRespondsToSelector(evaluatedClass, @selector(isSubclassOfClass:)))
        {
            return [evaluatedClass isSubclassOfClass:class];
        }
        
        return NO;
    }];

    
    NSSet *result = [classes filteredSetUsingPredicate:predicate];
    
    return (0 != [result count]) ? result : nil;
}
