//
//  UITableView+IDPCellLoading.m
//  IDPKit
//
//  Created by Denis Halabuzar on 5/24/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "UITableView+IDPCellLoading.h"
#import "UINib+IDPExtensions.h"

@implementation UITableView (IDPCellLoading)

- (id)dequeueCell:(Class)theClass {
    return [self dequeueCell:theClass withOwner:nil];
}

- (id)dequeueCell:(Class)theClass withOwner:(id)owner; {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(theClass)];
    if (cell == nil) {
        cell = [UINib loadClass:theClass withOwner:owner];
    }
    
    return cell;
}

@end
