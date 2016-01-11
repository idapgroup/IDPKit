//
//  NSTableView+IDPExtension.m
//  OSX
//
//  Created by Artem Chabannyi on 1/8/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSTableView+IDPExtension.h"

@implementation NSTableView (IDPExtension)

- (NSTableRowView *)rowViewAtRow:(NSInteger)row {
    return [self rowViewAtRow:row makeIfNecessary:NO];
}

- (NSView *)cellAtRow:(NSInteger)row {
    return [self viewAtColumn:0 row:row makeIfNecessary:NO];
}

- (NSView *)cellForView:(NSView *)view {
    return [self cellAtRow:[self rowForView:view]];
}

- (NSView *)cellForIdentifier:(NSString *)identifier
                      nibName:(NSString *)nibName
                        owner:(id)owner
{
    if ([self.registeredNibsByIdentifier valueForKey:identifier] == nil) {
        [self registerNib:[[NSNib alloc] initWithNibNamed:nibName bundle:nil] forIdentifier:identifier];
    }
    
    return [self makeViewWithIdentifier:identifier owner:owner];
}

- (NSView *)cellForIdentifier:(NSString *)identifier owner:(id)owner {
    return [self cellForIdentifier:identifier nibName:identifier owner:owner];
}

- (NSView *)cellForIdentifier:(NSString *)identifier {
    return [self cellForIdentifier:identifier owner:nil];
}

@end
