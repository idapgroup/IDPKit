//
//  UIStoryboard+IDPExtensions.h
//  liverpool1
//
//  Created by Oleksa 'trimm' Korin on 7/4/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (IDPExtensions)

+ (id)instantiateViewControllerWithClass:(Class)theClass
                    inStoryboardWithName:(NSString *)name;

+ (id)instantiateViewControllerWithClass:(Class)theClass
                    inStoryboardWithName:(NSString *)name
                                  bundle:(NSBundle *)bundle;

+ (id)instantiateViewControllerWithIdentifier:(NSString *)identifier
                         inStoryboardWithName:(NSString *)name;

+ (id)instantiateViewControllerWithIdentifier:(NSString *)identifier
                         inStoryboardWithName:(NSString *)name
                                       bundle:(NSBundle *)bundle;

- (id)instantiateViewControllerWithClass:(Class)theClass;

@end
