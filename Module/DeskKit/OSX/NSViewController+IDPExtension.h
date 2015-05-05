//
//  NSViewController+IDPExtension.h
//  MovieScript
//
//  Created by Artem Chabanniy on 29/08/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define IDPViewControllerViewOfClassGetterSynthesize(theClass, getterName) \
- (theClass *)getterName { \
    if ([self.view isKindOfClass:[theClass class]]) {\
        return (theClass *)self.view;\
    }\
    return nil;\
}

@interface NSViewController (IDPExtension)

@end
