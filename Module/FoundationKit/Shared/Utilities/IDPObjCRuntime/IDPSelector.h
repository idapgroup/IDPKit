//
//  IDPSelector.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/7/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IDPStringFromSEL(value) NSStringFromSelector(@selector(value))
#define IDPSEL(value) [IDPSelector objectWithSelector:@selector(value)]

@interface IDPSelector : NSObject
@property (nonatomic, readonly) SEL value;

+ (instancetype)objectWithSelector:(SEL)selector;

- (instancetype)initWithSelector:(SEL)selector NS_DESIGNATED_INITIALIZER;

- (BOOL)isEqualToSelector:(IDPSelector *)selector;
- (BOOL)isEqualToSEL:(SEL)selector;

@end
