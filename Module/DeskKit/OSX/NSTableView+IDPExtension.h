//
//  NSTableView+IDPExtension.h
//  OSX
//
//  Created by Artem Chabannyi on 1/8/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTableView (IDPExtension)

/**
 Shortcut for rowViewAtRow:makeIfNecessary:
 Pass NO to makeIfNecessary:
 */
- (NSTableRowView *)rowViewAtRow:(NSInteger)row;

/**
 Return cell for 0 column if it exist.
 */
- (NSView *)cellAtRow:(NSInteger)row;

/**
 Return cell if it exist for it subview.
 */
- (NSView *)cellForView:(NSView *)view;

/**
 Load or register if needed and load cell from tableView.
 */
- (NSView *)cellForIdentifier:(NSString *)identifier
                      nibName:(NSString *)nibName
                        owner:(id)owner;

/**
 Load or register if needed and load cell from tableView.
 Identifier and nib name of cell must be the same.
 */
- (NSView *)cellForIdentifier:(NSString *)identifier owner:(id)owner;

/**
 Load or register if needed and load cell from tableView.
 Identifier and nib name of cell must be the same.
 File owner is nil.
 */
- (NSView *)cellForIdentifier:(NSString *)identifier;

@end
