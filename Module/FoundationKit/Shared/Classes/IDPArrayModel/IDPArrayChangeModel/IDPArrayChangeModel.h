//
//  IDPArrayChangeModel.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/22/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPArrayChangeModel : NSObject
@property (nonatomic, weak, readonly) id  array;

+ (instancetype)modelWithArray:(id)array;

- (instancetype)initWithArray:(id)array NS_DESIGNATED_INITIALIZER;

@end
