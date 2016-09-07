//
//  RandomViewController.h
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface RandomViewController : UIViewController<UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, assign) int nIndex;
@property (nonatomic, assign) int nCardIndex;

@property (weak, nonatomic) IBOutlet UIImageView *img_Card;

- (IBAction)press_Action_Button:(id)sender;
@end
