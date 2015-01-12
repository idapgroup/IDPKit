//
//  NSNib+InitMethods.m
//  IDPAnimationWindow
//
//  Created by Vadim Lavrov Viktorovich on 11/22/12.
//  Copyright (c) 2012 IDAP Group. All rights reserved.
//

#import "NSNib+IDPExtension.h"

NSString * const IDPNilObjectInNibException          = @"IDPNilObjectInNibException";

static NSString * const IDPNilObjectInNibDescription = @"NSNib object doesn't contain the object of class %@ that needs instantiation.";

@interface NSNib (InitMethodsPrivate)
+ (void)raiseNilObjectInNibExceptionWithClass:(Class)theClass;
@end

@implementation NSNib (InitMethodsPrivate)

+ (void)raiseNilObjectInNibExceptionWithClass:(Class)theClass {
    NSString *exceptionName = [NSString stringWithFormat:IDPNilObjectInNibDescription, NSStringFromClass(theClass)];
    [NSException exceptionWithName:IDPNilObjectInNibException
                            reason:exceptionName
                          userInfo:nil];
}

@end

@implementation NSNib (IDPExtension)

+ (id)objectOfClass:(Class)theClass {
    return [self objectOfClass:theClass withBundle:nil withOwner:nil];
}

+ (id)objectOfClass:(Class)theClass
          withOwner:(id)owner
{
    return [self objectOfClass:theClass withBundle:nil withOwner:owner];
}

+ (id)objectOfClass:(Class)theClass
         withBundle:(NSBundle *)bundle
{
    return [self objectOfClass:theClass withBundle:bundle withOwner:nil];
}

+ (id)objectOfClass:(Class)theClass
         withBundle:(NSBundle *)bundle
          withOwner:(id)owner
{
    NSString *name = NSStringFromClass(theClass);
    NSNib *nib = [[[self alloc] initWithNibNamed:name bundle:bundle] autorelease];
    return [nib instantiateObjectOfClass:theClass objectOwner:owner];
}

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses {
    
    return [self objectsOfClasses:(NSArray *)arrayOfTheClasses withBundle:nil withOwner:nil];
}

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                    withOwner:(id)owner
{
    return [self objectsOfClasses:(NSArray *)arrayOfTheClasses withBundle:nil withOwner:owner];
}

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                   withBundle:(NSBundle *)bundle
{
    return [self objectsOfClasses:(NSArray *)arrayOfTheClasses withBundle:bundle withOwner:nil];
}

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                   withBundle:(NSBundle *)bundle
                    withOwner:(id)owner
{
    NSMutableArray *objects = nil;
    Class theClass = nil;
    id<NSObject> object = nil;
        
    for (theClass in arrayOfTheClasses) {
        object = [self objectOfClass:[theClass class] withBundle:bundle withOwner:owner];
        if (object == nil) {
            [self raiseNilObjectInNibExceptionWithClass:[theClass class]];
        }
        [objects addObject:object];
    }
    
    return [NSArray arrayWithArray:objects];
}

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                  withNibName:(NSString *)name
{
    return [self objectsOfClasses:arrayOfTheClasses withNibName:name withBundle:nil withOwner:nil];
}

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                  withNibName:(NSString *)name
                    withOwner:(id)owner
{
    return [self objectsOfClasses:arrayOfTheClasses withNibName:name withBundle:nil withOwner:owner];
}

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                  withNibName:(NSString *)name
                   withBundle:(NSBundle *)bundle
{
    return [self objectsOfClasses:arrayOfTheClasses withNibName:name withBundle:bundle withOwner:nil];
}

+ (NSArray *)objectsOfClasses:(NSArray *)arrayOfTheClasses
                  withNibName:(NSString *)name
                   withBundle:(NSBundle *)bundle
                    withOwner:(id)owner
{
    return [[[[self alloc] initWithNibNamed:name bundle:bundle] autorelease] instantiateObjectsOfClasses:arrayOfTheClasses objectsOwner:owner];
}

- (BOOL)portableInstantiateWithOwner:(id)owner topLevelObjects:(NSArray **)topLevelObjects {
    BOOL result = NO;
    
    if ([self respondsToSelector:@selector(instantiateWithOwner: topLevelObjects:)] == YES) {
        result = [self instantiateWithOwner:owner topLevelObjects:topLevelObjects];
    } else if ([self respondsToSelector:@selector(instantiateNibWithOwner:topLevelObjects:)] == YES) {
        #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        result = [self instantiateNibWithOwner:nil topLevelObjects:topLevelObjects];
        #pragma GCC diagnostic warning "-Wdeprecated-declarations"
        
        for (id<NSObject > object in *topLevelObjects) {
            [object autorelease];
        }
    }
    
    return result;
}

- (id)instantiateObjectOfClass:(Class)theClass {
    
    return [self instantiateObjectOfClass:theClass objectOwner:nil];
}

- (id)instantiateObjectOfClass:(Class)theClass objectOwner:(id)owner {
    NSArray *arrayOfObjects = nil;
    [self portableInstantiateWithOwner:owner topLevelObjects:&arrayOfObjects];
    
    id<NSObject> object = nil;
    
    for (object in arrayOfObjects) {
        
        if ([object isMemberOfClass:theClass]) {
            break;
        }
    }
    
    return object;

}

- (NSArray *)instantiateObjectsOfClasses:(NSArray *)arrayOfTheClasses {
    return [self instantiateObjectsOfClasses:arrayOfTheClasses objectsOwner:nil];
}

- (NSArray *)instantiateObjectsOfClasses:(NSArray *)arrayOfTheClasses objectsOwner:(id)owner {
    NSMutableArray *objects = nil;
    Class theClass = nil;
    id<NSObject> object = nil;
        
    for (theClass in arrayOfTheClasses){
        object = [self instantiateObjectOfClass:theClass objectOwner:owner];
        
        if (object == nil) {
            [[self class] raiseNilObjectInNibExceptionWithClass:theClass];
        }
        [objects addObject:object];
    }
    return [NSArray arrayWithArray:objects];
}

@end