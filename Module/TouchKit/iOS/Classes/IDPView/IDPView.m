//
//  IDPView.m
//  Geotunes
//
//  Created by Artem Chabanniy on 2/6/14.
//  Copyright (c) 2014 IDAP Group. All rights reserved.
//

#import "IDPView.h"
#import "IDPLoadingView.h"

@interface IDPView ()

@property (nonatomic, retain) IDPLoadingView *loadingView;

@end

@implementation IDPView

- (void)dealloc {
    self.loadingView = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public methodds

- (void)presentLoadingView {
    if (!self.loadingView) {
        self.loadingView = [IDPLoadingView loadingViewInView:self];
    }
}

- (void)hideLoadingView {
    if (self.loadingView) {
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }
}

- (void)presentLoadingViewWithMessage:(NSString *)message {
    if (!self.loadingView) {
        self.loadingView = [IDPLoadingView loadingViewInView:self
                                                 withMessage:message];
    }
}

@end
