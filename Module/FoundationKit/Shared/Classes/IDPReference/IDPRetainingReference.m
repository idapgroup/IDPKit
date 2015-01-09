//
//  IDPRetainingReference.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPRetainingReference.h"

@interface IDPRetainingReference ()
@property (nonatomic, retain) id object;
@end

@implementation IDPRetainingReference

@synthesize object  = _object;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.object = nil;
    
    [super dealloc];
}

@end
