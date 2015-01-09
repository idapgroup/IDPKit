//
//  UITableView+IDPCellLoading.h
//  IDPKit
//
//  Created by Denis Halabuzar on 5/24/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (IDPCellLoading)

- (id)dequeueCell:(Class)theClass;

- (id)dequeueCell:(Class)theClass withOwner:(id)owner;

@end
