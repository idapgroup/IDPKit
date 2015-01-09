//
//  IDPShareObject.m
//  IDPKit
//
//  Created by Alexander on 6/24/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPShareObject.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

static NSString *kIDPFailSendMessage        = @"Failed to send message.";
static NSString *kIDPSendMessage            = @"Message sent.";
static NSString *kIDPMailSentFaild          = @"Mail sent faild.";
static NSString *kIDPMailSent               = @"Mail sent.";
static NSString *kIDPMailStored             = @"Mail is stored.";
static NSString *kIDPOk                     = @"Ok";
static NSString *kIDPFileName               = @"share item.png";
static NSString *kIDPImageType              = @"image/png";
static NSString *kIDPError                  = @"Error";
static NSString *kIDPUnAvailableTweeter     = @"UnAvailable Tweeter";
static NSString *kIDPUnAvailableFacebook    = @"UnAvailable Facebook";

@interface IDPShareObject () <  MFMessageComposeViewControllerDelegate,
                                MFMailComposeViewControllerDelegate>
@property (nonatomic, retain)   UIViewController    *pressentController;

@end

@implementation IDPShareObject

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.pressentController = nil;
    
    [super dealloc];
}

- (id)initWithPressentingController:(UIViewController *)pressentingViewController {
    self = [super init];
    if (self) {
        self.pressentController = pressentingViewController;
    }
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)shareTwitterWith:(NSString *)text Image:(UIImage *)image Url:(NSString *)url {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        [self shareWith:text Image:image Url:url Type:SLServiceTypeTwitter];
    }
    else{
        [[[[UIAlertView alloc] initWithTitle:kIDPError
                                     message:kIDPUnAvailableTweeter
                                    delegate:self
                           cancelButtonTitle:kIDPOk
                           otherButtonTitles:nil, nil] autorelease] show];
    }
}

- (void)shareFacebookWith:(NSString *)text Image:(UIImage *)image Url:(NSString *)url {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        [self shareWith:text Image:image Url:url Type:SLServiceTypeFacebook];
    }
    else{
        [[[[UIAlertView alloc] initWithTitle:kIDPError
                                     message:kIDPUnAvailableFacebook
                                    delegate:self
                           cancelButtonTitle:kIDPOk
                           otherButtonTitles:nil, nil] autorelease] show];
    }
}

- (void)sendSmsWith:(NSString *)text {
    MFMessageComposeViewController *messageViewController = [[[MFMessageComposeViewController alloc] init] autorelease];
	if ([MFMessageComposeViewController canSendText]) {
        
        if (text) {
            messageViewController.body = text;
        }
        
		[messageViewController setMessageComposeDelegate:self];
		[self.pressentController presentViewController:messageViewController
                                              animated:YES
                                            completion:nil];
	}
}

- (void)sendEmailWith:(NSString *)text
                Image:(UIImage *)image
              Subject:(NSString *)subject
                   To:(NSString *)to
                   Cc:(NSArray *)cc
                  Bcc:(NSArray *)bcc
{
    MFMailComposeViewController *messageViewController = [[[MFMailComposeViewController alloc] init] autorelease];
    if ([MFMailComposeViewController canSendMail]) {
        [messageViewController setMailComposeDelegate:self];
        
        if (image != nil) {
            [messageViewController addAttachmentData:UIImagePNGRepresentation(image)
                                            mimeType:kIDPImageType
                                            fileName:kIDPFileName];
        }
        
        subject ? [messageViewController setSubject:subject ]               : nil;
        text    ? [messageViewController setMessageBody:text isHTML:NO ]    : nil;
        to      ? [messageViewController setToRecipients:@[to] ]            : nil;
        cc      ? [messageViewController setCcRecipients:cc ]               : nil;
        bcc     ? [messageViewController setBccRecipients:bcc ]             : nil;
        
        [self.pressentController presentViewController:messageViewController
                                              animated:YES
                                            completion:nil];
    } else {
        [self loadIOSMessageWith:subject Body:text];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)loadIOSMessageWith:(NSString *)subject Body:(NSString *)body {
    NSString *recipients = [NSString stringWithFormat:@"mailto:?&subject=%@",subject];
    NSString *bodyStr = [NSString stringWithFormat:@"&body=%@", body];
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, bodyStr];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (NSString *)fixedLenthString:(NSString *)text {
    NSMutableString *initialText = [NSMutableString stringWithCapacity:[text length]];
    
    if ([text length] > 100) {
        NSArray *worldArray = [text componentsSeparatedByString:@" "];
        
        for (CFIndex index = 0; index < [worldArray count] && [initialText length] < 95; ++ index) {
            NSString *word = [NSString stringWithFormat:@"%@", [worldArray objectAtIndex:index]];
            [initialText  appendFormat:@"%@ ", [initialText length] < 90 ? word : @"..."];
        }
        return initialText;
    }
    return text;
}

- (void)shareWith:(NSString *)text
            Image:(UIImage *)image
              Url:(NSString *)url
             Type:(NSString *)type
{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:type];
    
    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"Cancelled");
        } else {
            NSLog(@"Done");
        }
        [controller dismissViewControllerAnimated:YES completion:nil];
    };
    controller.completionHandler = myBlock;
    
    if (text) {
        NSString *initialText = [self fixedLenthString:text];
        [controller setInitialText:initialText];
    } else if (image) {
        [controller addImage:image];
    } else if (url) {
        [controller addURL:[NSURL URLWithString:url]];
    }
    [self.pressentController presentViewController:controller animated:YES completion:nil];
}

#pragma mark -
#pragma mark MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    UIAlertView *alertResult = [[[UIAlertView alloc] initWithTitle:nil
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:kIDPOk
                                                 otherButtonTitles:nil, nil] autorelease];
    switch (result) {
        case MessageComposeResultCancelled:
            [alertResult setMessage:kIDPFailSendMessage];
            break;
        case MessageComposeResultFailed:
            [alertResult setMessage:kIDPFailSendMessage];
            break;
        case MessageComposeResultSent:
            [alertResult setMessage:kIDPSendMessage];
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    [alertResult show];
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate


- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    UIAlertView *alertResult = [[[UIAlertView alloc] initWithTitle:nil
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:kIDPOk
                                                 otherButtonTitles:nil, nil] autorelease];
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [alertResult setMessage:kIDPMailSentFaild];
            break;
        case MFMailComposeResultSaved:
            [alertResult setMessage:kIDPMailStored];
            break;
        case MFMailComposeResultSent:
            [alertResult setMessage:kIDPMailSent];
            break;
        case MFMailComposeResultFailed:
            [alertResult setMessage:kIDPMailSentFaild];
            break;
        default:
            [alertResult setMessage:kIDPMailSentFaild];
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    [alertResult show];
}

@end
