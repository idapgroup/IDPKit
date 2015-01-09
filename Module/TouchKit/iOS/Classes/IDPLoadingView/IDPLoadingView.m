//
//  IDPLoadingView.m
//  ClipIt
//
//  Created by Oleksa 'trimm' Korin on 2/26/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPLoadingView.h"

#import "CGGeometry+IDPExtensions.h"
#import "NSObject+IDPExtensions.h"

#import "IDPPropertyMacros.h"

static const CGFloat IDPLoadingViewFadeDuration   = 0.3f;

@interface IDPLoadingView ()
@property (nonatomic, retain) UIActivityIndicatorView   *activityIndicator;
@property (nonatomic, retain) UILabel                   *label;

- (id)initWithFrame:(CGRect)frame andLabel:(NSString *)message;
- (void)configureLable:(NSString *)message;
- (void)configureactivityIndicator;

@end

@implementation IDPLoadingView

@synthesize activityIndicator   = _activityIndicator;
@synthesize label               = _label;

#pragma mark -
#pragma mark Class Methods

+ (id)loadingViewInView:(UIView *)view {
    IDPLoadingView *loadingView = [[[IDPLoadingView alloc] initWithFrame:CGZeroOriginRectWithRect(view.frame)] autorelease];
    loadingView.alpha = 0.0f;
    [view addSubview:loadingView];
    [UIView animateWithDuration:IDPLoadingViewFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         loadingView.alpha = 1.0f;
                     }
                     completion:nil];
    
    return loadingView;
}

+ (id)loadingViewInView:(UIView *)view withMessage:(NSString *)message {
    IDPLoadingView *loadingView = [[[IDPLoadingView alloc] initWithFrame:CGZeroOriginRectWithRect(view.frame) andLabel:message] autorelease];
    loadingView.alpha = 0.0f;
    [view addSubview:loadingView];
    [UIView animateWithDuration:IDPLoadingViewFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         loadingView.alpha = 1.0f;
                     }
                     completion:nil];
    
    return loadingView;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.activityIndicator = nil;
    self.label = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        [self baseInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureactivityIndicator];
        [self baseInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andLabel:(NSString *)message {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureLable:message];
        [self configureactivityIndicator];
        [self baseInit];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    
    return self;
}

- (void)baseInit {
    [super baseInit];
    self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];

    [self addSubview:self.label];
    [self.activityIndicator startAnimating];
    [self addSubview:self.activityIndicator];
    [self setFrame:self.frame];
}

#pragma mark -
#pragma mark Accessors

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator {
    [_activityIndicator removeFromSuperview];
    IDPNonatomicRetainPropertySynthesize(_activityIndicator, activityIndicator);
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.activityIndicator.center = CGPointMake(CGMidX(frame),
                                                CGMidY(frame));
}

#pragma mark -
#pragma mark Private

- (void)configureLable:(NSString *)message {
    self.label = [[[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x, CGMidY(self.frame) - 45, self.frame.size.width, 25)] autorelease];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor whiteColor];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.text = message;

}

- (void)configureactivityIndicator {
    
    CGRect frame = CGZeroOriginRectWithRect(self.frame);
    self.activityIndicator.center = CGPointMake(CGMidX(frame),
                                                CGMidY(frame));

    self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    self.activityIndicator.frame = CGZeroOriginRectWithRect(self.frame);
    
}

@end
