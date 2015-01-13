//
//  NSPathUtilities+IDPExtensions.m
//  iOS
//
//  Created by Oleksa Korin on 13/1/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSPathUtilities+IDPExtensions.h"

NSString *NSSearchPathForDirectory(NSSearchPathDirectory directory) {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
}