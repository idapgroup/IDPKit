//
//  NSNib+InitMethods.h
//  IDPAnimationWindow
//
//  Created by Vadim Lavrov Viktorovich on 11/22/12.
//  Copyright (c) 2012 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

FOUNDATION_EXTERN NSString * const IDPNilObjectInNibException;

@interface NSNib (IDPExtension)

+ (id)objectOfClass:(Class)theClass;
+ (id)objectOfClass:(Class)theClass
          withOwner:(id)owner;

+ (id)objectOfClass:(Class)theClass
         withBundle:(NSBundle *)bundle;

+ (id)objectOfClass:(Class)theClass
         withBundle:(NSBundle *)bundle
          withOwner:(id)owner;

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses;
+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                    withOwner:(id)owner;

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                   withBundle:(NSBundle *)bundle;
+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                   withBundle:(NSBundle *)bundle
                    withOwner:(id)owner;

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                  withNibName:(NSString *)name;
+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                  withNibName:(NSString *)name
                    withOwner:(id)owner;

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                  withNibName:(NSString *)name
                   withBundle:(NSBundle *)bundle;
+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                  withNibName:(NSString *)name
                   withBundle:(NSBundle *)bundle
                    withOwner:(id)owner;

- (id)instantiateObjectOfClass:(Class)theClass;
- (id)instantiateObjectOfClass:(Class)theClass objectOwner:(id)owner;

- (NSArray *)instantiateObjectsOfClasses:(NSArray *)arrayOfTheClasses;
- (NSArray *)instantiateObjectsOfClasses:(NSArray *)arrayOfTheClasses objectsOwner:(id)owner;

- (BOOL)portableInstantiateWithOwner:(id)owner topLevelObjects:(NSArray **)topLevelObjects;

@end
