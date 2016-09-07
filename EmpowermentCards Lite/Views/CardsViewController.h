//
//  CardsViewController.h
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardsViewController : UIViewController

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *btnTop;
@property (weak, nonatomic) IBOutlet UIButton *btnCenter01;
@property (weak, nonatomic) IBOutlet UIButton *btnCenter02;
@property (weak, nonatomic) IBOutlet UIButton *btnCenter03;
@property (weak, nonatomic) IBOutlet UIButton *btnCenter04;
@property (weak, nonatomic) IBOutlet UIButton *btnCenter05;
@property (weak, nonatomic) IBOutlet UIButton *btnBottom;

@property (weak, nonatomic) IBOutlet UIButton *btnUpgrade;

//Buttons' Event
- (IBAction)press_Top_Button:(id)sender;
- (IBAction)press_Center01_Button:(id)sender;
- (IBAction)press_Center02_Button:(id)sender;
- (IBAction)press_Center03_Button:(id)sender;
- (IBAction)press_Center04_Button:(id)sender;
- (IBAction)press_Center05_Button:(id)sender;
- (IBAction)press_Bottom_Button:(id)sender;
- (IBAction)press_UpgradApp_Button:(id)sender;


//Tab bar Buttons Event
- (IBAction)press_About_Button:(id)sender;
- (IBAction)press_Cards_Button:(id)sender;
- (IBAction)press_Random_Button:(id)sender;
- (IBAction)press_Alerts_Button:(id)sender;
- (IBAction)press_MissedAlert_Button:(id)sender;
@end
