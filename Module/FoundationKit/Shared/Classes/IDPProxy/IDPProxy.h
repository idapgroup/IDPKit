//
//  IDPProxy.h
//  iOS
//
//  Created by Oleksa Korin on 9/3/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPProxy : NSProxy <NSCopying>
@property (nonatomic, readonly) id  target;

+ (id)proxyWithTarget:(id)target;

- (id)initWithTarget:(id)target;

@end
