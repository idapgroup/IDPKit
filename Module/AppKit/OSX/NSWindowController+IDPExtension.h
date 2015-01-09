//
//  NSWindowController+Initialization.h
//  CocoaTest
//
//  Created by Denis Halabuzar on 11/23/12.
//  Copyright (c) 2012 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSWindowController (IDPExtension)

/**
 This method call initWithWindowNibName: based on window controller class name.
 @return Return new autorelease window controller.
 */
+ (id)controllerWithDefaultNib;

@end
