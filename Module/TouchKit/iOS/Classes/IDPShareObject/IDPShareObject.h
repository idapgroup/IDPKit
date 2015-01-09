//
//  IDPShareObject.h
//  IDPKit
//
//  Created by Alexander on 6/24/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This class will share the data encapsulates the logic. 
 *  Forcing the developer not to use additional methods.
 *
 */
@interface IDPShareObject : NSObject
@property (nonatomic, readonly) UIViewController    *pressentController;

//*Call init* with the current controller*/
- (id)initWithPressentingController:(UIViewController *)pressentingViewController;
- (void)shareTwitterWith:(NSString *)text Image:(UIImage *)image Url:(NSString *)url;
- (void)shareFacebookWith:(NSString *)text Image:(UIImage *)image Url:(NSString *)url;
- (void)sendSmsWith:(NSString *)text;
- (void)sendEmailWith:(NSString *)text
                Image:(UIImage *)image
              Subject:(NSString *)subject
                   To:(NSString *)to
                   Cc:(NSArray *)cc
                  Bcc:(NSArray *)bcc;

@end
