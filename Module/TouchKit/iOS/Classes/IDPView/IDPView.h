//
//  IDPView.h
//  Geotunes
//
//  Created by Artem Chabanniy on 2/6/14.
//  Copyright (c) 2014 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDPView : UIView

- (void)presentLoadingView;
- (void)hideLoadingView;
- (void)presentLoadingViewWithMessage:(NSString *)message;

@end
