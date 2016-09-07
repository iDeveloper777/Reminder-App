//
//  SelectedCardViewController.h
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface SelectedCardViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (strong,nonatomic) NSString *imgCardName;

@property (nonatomic, assign) int nIndex;
@property (nonatomic, assign) int nCardIndex;

@property (weak, nonatomic) IBOutlet UIImageView *img_Card;

- (IBAction)press_Back_Button:(id)sender;
- (IBAction)press_Action_Button:(id)sender;

@end
