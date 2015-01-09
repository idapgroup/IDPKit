//
//  NSNib+NIBLoading.h
//  Phingo
//
//  Created by trimm on 27.07.11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UINib (IDPExtensions)

// loads the class from a Nib, whose name is the same, as the class name
+ (id)loadClass:(Class)theClass;
+ (id)loadClass:(Class)theClass inBundle:(NSBundle *)theBundle;
+ (id)loadClass:(Class)theClass fromNibNamed:(NSString *)nibName inBundle:(NSBundle *)theBundle;
+ (id)loadClass:(Class)theClass withOwner:(id)theOwner;

- (id)loadClass:(Class)theClass;
- (id)loadClass:(Class)theClass withOwner:(id)theOwner;

@end
