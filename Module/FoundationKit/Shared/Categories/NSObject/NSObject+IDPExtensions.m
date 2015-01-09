//
//  NSObject+IDPExtensions.m
//  ClipIt
//
//  Created by Vadim Lavrov Viktorovich on 2/23/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSObject+IDPExtensions.h"

@implementation NSObject (IDPExtensions)

+ (id)object {
    return [[self new] autorelease];
}

- (void)baseInit {
    
}

+ (NSString *)stringOfClass {
    return NSStringFromClass(self);
}

@end
