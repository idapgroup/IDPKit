//
//  IDPModelProxy.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/3/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPProxy.h"

@interface IDPModelProxy : IDPProxy

- (void)executeOperation:(NSOperation *)operation;

- (NSBlockOperation *)executeBlock:(id)block;

@end
