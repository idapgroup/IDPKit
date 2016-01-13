//
//  NSObject+IDPRuntime.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/13/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef OBJC_ENUM(uintptr_t, IDPPropertyPolicy) {
    // Specifies a weak property.
    IDPPropertyAssign = OBJC_ASSOCIATION_ASSIGN,
    
    // Specifies a nonatomic strong property.
    IDPPropertyNonatomicStrong = OBJC_ASSOCIATION_RETAIN_NONATOMIC,
    
    // Specifies a nonatomic copy property.
    IDPPropertyNonatomicCopy = OBJC_ASSOCIATION_COPY_NONATOMIC,

    // Specifies an atomic strong property.
    IDPPropertyAtomicStrong = OBJC_ASSOCIATION_RETAIN,

    // Specifies an atomic copy property.
    IDPPropertyAtomicCopy = OBJC_ASSOCIATION_COPY
};

typedef id(^IDPBlockWithIMP)(IMP implementation);

@interface NSObject (IDPRuntime)

+ (void)setBlock:(IDPBlockWithIMP)block forSelector:(SEL)selector;

- (void)setValue:(id)value forPropertyKey:(const NSString *)key associationPolicy:(IDPPropertyPolicy)policy;
- (id)valueForPropertyKey:(const NSString *)key;

// TODO: add value for property name, where key could be not a string without const

@end
