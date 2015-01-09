//
//  NSViewController+IDPExtension.m
//  MovieScript
//
//  Created by Artem Chabanniy on 29/08/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSViewController+IDPExtension.h"

@implementation NSViewController (IDPExtension)

+ (id)controllerWithDefaultNib {
    return [[[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil] autorelease];
}

@end
