//
//  NSBundle+NIBLoading.h
//  Phingo
//
//  Created by trimm on 27.07.11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSBundle (IDPExtensions)
+ (id)loadClass:(Class)theClass fromDefaultNibWithOwner:(id)theOwner;
+ (id)loadClass:(Class)theClass fromNibNamed:(NSString *)theNibName owner:(id)theOwner;
+ (id)loadClass:(Class)theClass fromNibNamed:(NSString *)theNibName owner:(id)theOwner options:(NSDictionary *)options;
+ (NSString *)pathForResource:(NSString *)name ofType:(NSString *)extension;

- (id)loadClass:(Class)theClass fromDefaultNibWithOwner:(id)theOwner;
- (id)loadClass:(Class)theClass fromNibNamed:(NSString *)theNibName owner:(id)theOwner;
- (id)loadClass:(Class)theClass fromNibNamed:(NSString *)theNibName owner:(id)theOwner options:(NSDictionary *)options;
@end
