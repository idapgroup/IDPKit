//
//  NSWindowController+Initialization.h
//  CocoaTest
//
//  Created by Denis Halabuzar on 11/23/12.
//  Copyright (c) 2012 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define IDPWindowControllerWindowOfClassGetterSynthesize(theClass, getterName) \
- (theClass *)getterName { \
    if ([self.window isKindOfClass:[theClass class]]) {\
        return (theClass *)self.window;\
    }\
    return nil;\
}

@interface NSWindowController (IDPExtension)

/**
 This method call initWithWindowNibName: based on window controller class name.
 @return Return new autorelease window controller.
 */
+ (instancetype)controllerWithDefaultNib;

@end
