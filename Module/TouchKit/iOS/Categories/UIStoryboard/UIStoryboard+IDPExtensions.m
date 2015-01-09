//
//  UIStoryboard+IDPExtensions.m
//  liverpool1
//
//  Created by Oleksa 'trimm' Korin on 7/4/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "UIStoryboard+IDPExtensions.h"

@implementation UIStoryboard (IDPExtensions)

+ (id)instantiateViewControllerWithClass:(Class)theClass
                    inStoryboardWithName:(NSString *)name
{
    return [self instantiateViewControllerWithClass:theClass
                               inStoryboardWithName:name
                                             bundle:nil];
}

+ (id)instantiateViewControllerWithClass:(Class)theClass
                    inStoryboardWithName:(NSString *)name
                                  bundle:(NSBundle *)bundle
{
    return [self instantiateViewControllerWithIdentifier:NSStringFromClass(theClass)
                                    inStoryboardWithName:name
                                                  bundle:bundle];
}

+ (id)instantiateViewControllerWithIdentifier:(NSString *)identifier
                         inStoryboardWithName:(NSString *)name
{
    return [self instantiateViewControllerWithIdentifier:identifier
                                    inStoryboardWithName:name
                                                  bundle:nil];
}

+ (id)instantiateViewControllerWithIdentifier:(NSString *)identifier
                         inStoryboardWithName:(NSString *)name
                                       bundle:(NSBundle *)bundle
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name
                                                         bundle:bundle];

    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

- (id)instantiateViewControllerWithClass:(Class)theClass {
    return [self instantiateViewControllerWithIdentifier:NSStringFromClass(theClass)];
}

@end
