//
//  CardsViewController.m
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import "CardsViewController.h"
#import "SelectACardViewController.h"
#import "AboutViewController.h"
#import "AppDelegate.h"

@interface CardsViewController (){
    UIColor *FONT_SELECTED_COLOR;
    UIColor *FONT_NORMAL_COLOR;
    
}

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FONT_NORMAL_COLOR = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    FONT_SELECTED_COLOR = [UIColor whiteColor];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (appDelegate.bPaid == 0)
        self.btnUpgrade.hidden = NO;
    else
        self.btnUpgrade.hidden = YES;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isSelectedTab2 = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Buttons' Event

- (IBAction)press_Top_Button:(id)sender {
    [self setDefaultButtons];
    [self.btnTop setBackgroundImage:[UIImage imageNamed:@"cards_Top_selected_button.png"] forState:UIControlStateNormal];
    [self.btnTop setTitleColor:FONT_SELECTED_COLOR forState:UIControlStateNormal];
    [self pushToSelectCardView:0];
}

- (IBAction)press_Center01_Button:(id)sender {
    [self setDefaultButtons];
    [self.btnCenter01 setBackgroundImage:[UIImage imageNamed:@"cards_Center_selected_button.png"] forState:UIControlStateNormal];
    [self.btnCenter01 setTitleColor:FONT_SELECTED_COLOR forState:UIControlStateNormal];
    
    [self pushToSelectCardView:1];
}

- (IBAction)press_Center02_Button:(id)sender {
    [self setDefaultButtons];
    [self.btnCenter02 setBackgroundImage:[UIImage imageNamed:@"cards_Center_selected_button.png"] forState:UIControlStateNormal];
    [self.btnCenter02 setTitleColor:FONT_SELECTED_COLOR forState:UIControlStateNormal];
    
    [self pushToSelectCardView:2];
}

- (IBAction)press_Center03_Button:(id)sender {
    [self setDefaultButtons];
    [self.btnCenter03 setBackgroundImage:[UIImage imageNamed:@"cards_Center_selected_button.png"] forState:UIControlStateNormal];
    [self.btnCenter03 setTitleColor:FONT_SELECTED_COLOR forState:UIControlStateNormal];
    
    [self pushToSelectCardView:3];
}

- (IBAction)press_Center04_Button:(id)sender {
    [self setDefaultButtons];
    [self.btnCenter04 setBackgroundImage:[UIImage imageNamed:@"cards_Center_selected_button.png"] forState:UIControlStateNormal];
    [self.btnCenter04 setTitleColor:FONT_SELECTED_COLOR forState:UIControlStateNormal];
    
    [self pushToSelectCardView:4];
}

- (IBAction)press_Center05_Button:(id)sender {
    [self setDefaultButtons];
    [self.btnCenter04 setBackgroundImage:[UIImage imageNamed:@"cards_Center_selected_button.png"] forState:UIControlStateNormal];
    [self.btnCenter04 setTitleColor:FONT_SELECTED_COLOR forState:UIControlStateNormal];
    
    [self pushToSelectCardView:5];
}

- (IBAction)press_Bottom_Button:(id)sender {
    [self setDefaultButtons];
    [self.btnBottom setBackgroundImage:[UIImage imageNamed:@"cards_Bottom_selected_button.png"] forState:UIControlStateNormal];
    [self.btnBottom setTitleColor:FONT_SELECTED_COLOR forState:UIControlStateNormal];
    
    [self pushToSelectCardView:6];
}

- (IBAction)press_UpgradApp_Button:(id)sender {
//    NSURL *url = [[NSURL alloc] initWithString:@"itms://itunes.apple.com/us/app/apple-store/id375380948?mt=8"];
    NSURL *url = [[NSURL alloc] initWithString:@"https://itunes.apple.com/us/app/empowerment-cards/id626576224?mt=8"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) pushToSelectCardView:(int) nIndex{
    SelectACardViewController *selectACardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectACardView"];
    selectACardViewController.nIndex = nIndex;
    
    [self.navigationController pushViewController:selectACardViewController animated:YES];
}

- (void) setDefaultButtons{
    [self.btnTop setBackgroundImage:[UIImage imageNamed:@"cards_Top_normal_button.png"] forState:UIControlStateNormal];
    [self.btnTop setTitleColor:FONT_NORMAL_COLOR forState:UIControlStateNormal];
    
    [self.btnCenter01 setBackgroundImage:[UIImage imageNamed:@"cards_Center_normal_button.png"] forState:UIControlStateNormal];
    [self.btnCenter01 setTitleColor:FONT_NORMAL_COLOR forState:UIControlStateNormal];

    [self.btnCenter02 setBackgroundImage:[UIImage imageNamed:@"cards_Center_normal_button.png"] forState:UIControlStateNormal];
    [self.btnCenter02 setTitleColor:FONT_NORMAL_COLOR forState:UIControlStateNormal];

    [self.btnCenter03 setBackgroundImage:[UIImage imageNamed:@"cards_Center_normal_button.png"] forState:UIControlStateNormal];
    [self.btnCenter03 setTitleColor:FONT_NORMAL_COLOR forState:UIControlStateNormal];

    [self.btnCenter04 setBackgroundImage:[UIImage imageNamed:@"cards_Center_normal_button.png"] forState:UIControlStateNormal];
    [self.btnCenter04 setTitleColor:FONT_NORMAL_COLOR forState:UIControlStateNormal];

    [self.btnBottom setBackgroundImage:[UIImage imageNamed:@"cards_Bottom_normal_button.png"] forState:UIControlStateNormal];
    [self.btnBottom setTitleColor:FONT_NORMAL_COLOR forState:UIControlStateNormal];

}
#pragma mark Tabbar_Button_Events

- (IBAction)press_About_Button:(id)sender {
    AboutViewController *aboutViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutView"];
    [self  presentViewController:aboutViewController animated:NO completion:NULL];
}

- (IBAction)press_Cards_Button:(id)sender {
    
}

- (IBAction)press_Random_Button:(id)sender {
}

- (IBAction)press_Alerts_Button:(id)sender {
}

- (IBAction)press_MissedAlert_Button:(id)sender {
}

@end
