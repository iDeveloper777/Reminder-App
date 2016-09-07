//
//  AboutViewController.h
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 16/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *txtMoreInformation;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)press_URL:(id)sender;
- (IBAction)press_EmailAddress:(id)sender;

- (IBAction)pressTwitterLink:(id)sender;
- (IBAction)press_FaceLink:(id)sender;

//Tab bar Buttons Event
- (IBAction)press_About_Button:(id)sender;
- (IBAction)press_Cards_Button:(id)sender;
- (IBAction)press_Random_Button:(id)sender;
- (IBAction)press_Alerts_Button:(id)sender;
- (IBAction)press_MissedAlert_Button:(id)sender;

@end
