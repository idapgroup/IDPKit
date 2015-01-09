//
//  RSLModelDelegate.h
//  PhotoBombKit
//
//  Created by Oleksa Korin on 1/20/12.
//  Copyright (c) 2012 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPModel;

@protocol IDPModelObserver <NSObject>

@optional
- (void)modelDidLoad:(id)theModel;
- (void)modelDidFailToLoad:(id)theModel;
- (void)modelDidCancelLoading:(id)theModel;
- (void)modelDidChange:(id)theModel;
- (void)modelDidChange:(id)theModel message:(NSDictionary *)message;
- (void)modelDidUnload:(id)theModel;

@end
