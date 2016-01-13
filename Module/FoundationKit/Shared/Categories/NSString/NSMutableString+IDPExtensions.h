//
//  NSMutableString+IDPExtensions.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/13/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (IDPExtensions)

- (void)appendUTF8String:(const char *)UTF8String;

@end
