//
//  UIViewController+IDPExtensions.m
//  ClipIt
//
//  Created by Vadim Lavrov Viktorovich on 2/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "UIViewController+IDPExtensions.h"

@implementation UIViewController (IDPExtensions)

- (UITableView *)tableView {
    if ([self.view respondsToSelector:@selector(tableView)]) {
        return [self.view performSelector:@selector(tableView)];
    }
    return nil;
}

@end
