//
//  UIAlertView+ACExtensions.m
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/17/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "UIAlertView+IDPExtensions.h"

static NSString * const kOk             = @"OK";
static NSString * const kError          = @"Error";
static NSString * const kServerError    = @"There was a problem communicating with the server, please try again";
static NSString * const kInternetError  = @"Please ensure you have Internet access";

@implementation UIAlertView (IDPExtensions)

+ (void)showInternetConnectionError {
    [self showErrorWithMessage:kInternetError];
}

+ (void)showServerCommunicationError {
    [self showErrorWithMessage:kServerError];
}

+ (void)showErrorWithMessage:(NSString *)message {
    [self showAlertWithTitle:kError message:message];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:kOk
                                          otherButtonTitles:nil];
    [alert show];
    [alert autorelease];
}

+ (BOOL)isAlertViewVisible {
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        NSArray* subviews = window.subviews;
        if ([subviews count] > 0){
            for (id subview in subviews) {
                if ([subview isKindOfClass:[UIAlertView class]]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

@end
