//
//  AboutViewController.m
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 16/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import "AboutViewController.h"
#import "CardsViewController.h"
#import "AppDelegate.h"
#import "SATabBarController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    singleTap.numberOfTapsRequired = 1;
    [self.txtMoreInformation setUserInteractionEnabled:YES];
    [self.txtMoreInformation addGestureRecognizer:singleTap];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){ //iPad
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height * 3.6)];
    }else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        if (iOSDeviceScreenSize.height == 480){ //iphone 4
            [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height * 3.4)];
        }else{
            [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height * 3.3)];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showBadge" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tapGesture

- (void) tapGesture:(UITapGestureRecognizer *)gestureRecognizer{
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.ifnotdieting.com"];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark Button Events
- (IBAction)press_URL:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.ifnotdieting.com"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)press_EmailAddress:(id)sender {
    NSString *emailTitle = @"New Message";
    NSString *messageBody = @"";
    NSArray *toRecipents = [NSArray arrayWithObject:@"dr.rick@ifnotdieting.com.au"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setToRecipients:toRecipents];
    [mc setMessageBody:messageBody isHTML:NO];
    
    [self  presentViewController:mc animated:YES completion:NULL];
}

- (IBAction)pressTwitterLink:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"https://twitter.com/drrickk"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)press_FaceLink:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"https://www.facebook.com/pages/Dr-Rick-Kausman/134926533359630"];
    [[UIApplication sharedApplication] openURL:url];
}



#pragma mark mailComposeController
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark Tabbar_Button_Events

- (IBAction)press_About_Button:(id)sender {
}

- (IBAction)press_Cards_Button:(id)sender {
    //    CardsViewController *cardsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CardsView"];
    //    [self  presentViewController:cardsViewController animated:NO completion:NULL];
}

- (IBAction)press_Random_Button:(id)sender {
}

- (IBAction)press_Alerts_Button:(id)sender {
}

- (IBAction)press_MissedAlert_Button:(id)sender {
}
@end
