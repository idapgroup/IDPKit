//
//  IDPBlockTypes.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 3/10/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^IDPVoidBlock)(void);
typedef void(^IDPObjectBlock)(id object);
typedef void (^IDPEnumerationBlock)(id obj, NSUInteger idx, BOOL *stop);
typedef id(^IDPFactoryBlock)(void);
typedef BOOL(^IDPPredicateBlock)(id object, NSDictionary *bindings);