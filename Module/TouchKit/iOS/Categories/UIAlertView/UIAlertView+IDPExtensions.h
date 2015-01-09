//
//  UIAlertView+ACExtensions.h
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/17/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (IDPExtensions)

+ (void)showInternetConnectionError;
+ (void)showServerCommunicationError;
+ (void)showErrorWithMessage:(NSString *)message;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;
+ (BOOL)isAlertViewVisible;

@end
