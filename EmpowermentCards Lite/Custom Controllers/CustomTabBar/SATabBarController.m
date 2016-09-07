//
//  SATabBar.m
//  CustomTabbar
//
//  Created by RIGEL NETWORKS PVT. LTD on 05/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SATabBarController.h"

#import "CardsViewController.h"
#import "AppDelegate.h"

@implementation SATabBarController
@synthesize saTabBar;
@synthesize tab1IView;
@synthesize tab2IView;
@synthesize tab3IView;
@synthesize tab4IView;
@synthesize tab5IView;

@synthesize tab1Label;
@synthesize tab2Label;
@synthesize tab3Label;
@synthesize tab4Label;
@synthesize tab5Label;

@synthesize tab1SView;
@synthesize tab2SView;
@synthesize tab3SView;
@synthesize tab4SView;
@synthesize tab5SView;

@synthesize badgeView;
@synthesize badgeLabel;

/**
 Set initial view of tab bar
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    saTabBar.backgroundColor = [UIColor clearColor];
    [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage alloc] init]];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectMake(0, 0, width, 49);
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *tabBG = [[UIImageView alloc] initWithFrame:frame];
    [tabBG setImage:[UIImage imageNamed:@"tapbar_background.png"]];
    [backView addSubview:tabBG];
    
    
    tabWidth = width/5;
    
    
    //////////// Selected Tab star0
    //    selectedTab = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tabWidth, 49)];
    //
    //    UIImageView *selectedBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tabWidth, 49)];
    //    [selectedBG setImage:[UIImage imageNamed:@"selected_bg.png"]];
    //    [selectedTab addSubview:selectedBG];
    //
    //    UIImageView *topL = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tabWidth, 49)];
    //    [topL setImage:[UIImage imageNamed:@"tab_l.png"]];
    //    [topL setContentMode:UIViewContentModeTopLeft];
    //    //[selectedTab addSubview:topL];
    //
    //    UIImageView *topR = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tabWidth, 49)];
    //    [topR setImage:[UIImage imageNamed:@"tab_l.png"]];
    //    [topR setContentMode:UIViewContentModeTopRight];
    //    //[selectedTab addSubview:topR];
    //    [backView addSubview:selectedTab];
    
    UIButton* btnTab1 = [[UIButton alloc] initWithFrame:CGRectMake(2, 3, tabWidth, 31)];
    btnTab1.tag = 0;
    [btnTab1 addTarget:self action:@selector(btnTabPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.tab1SView=[[UIImageView alloc] initWithFrame:CGRectMake(2, 3, tabWidth, 31)];
    [self.tab1SView setImage:[UIImage imageNamed:@"tb_about_selected_button.png"]];
    [self.tab1SView setContentMode:UIViewContentModeScaleAspectFit];
    [backView addSubview:self.tab1SView];
    [backView addSubview:btnTab1];
    
    UIButton* btnTab2 = [[UIButton alloc] initWithFrame:CGRectMake(tabWidth+2, 3, tabWidth, 31)];
    btnTab2.tag = 1;
    [btnTab2 addTarget:self action:@selector(btnTabPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.tab2SView=[[UIImageView alloc] initWithFrame:CGRectMake(tabWidth+2, 3, tabWidth, 31)];
    [self.tab2SView setImage:[UIImage imageNamed:@"tb_cards_normal_button.png"]];
    [self.tab2SView setContentMode:UIViewContentModeScaleAspectFit];
    [backView addSubview:self.tab2SView];
    [backView addSubview:btnTab2];
    
    
    UIButton* btnTab3 = [[UIButton alloc] initWithFrame:CGRectMake(tabWidth*2+2, 3, tabWidth, 31)];
    btnTab3.tag = 2;
    [btnTab3 addTarget:self action:@selector(btnTabPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.tab3SView=[[UIImageView alloc] initWithFrame:CGRectMake(tabWidth*2+2, 3, tabWidth, 31)];
    [self.tab3SView setImage:[UIImage imageNamed:@"tb_random_normal_button.png"]];
    [self.tab3SView setContentMode:UIViewContentModeScaleAspectFit];
    [backView addSubview:self.tab3SView];
    [backView addSubview:btnTab3];
    
    UIButton* btnTab4 = [[UIButton alloc] initWithFrame:CGRectMake(tabWidth*3+2, 3, tabWidth, 31)];
    btnTab4.tag = 3;
    [btnTab4 addTarget:self action:@selector(btnTabPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.tab4SView=[[UIImageView alloc] initWithFrame:CGRectMake(tabWidth*3+2, 3, tabWidth, 31)];
    [self.tab4SView setImage:[UIImage imageNamed:@"tb_alerts_normal_button.png"]];
    [self.tab4SView setContentMode:UIViewContentModeScaleAspectFit];
    [backView addSubview:self.tab4SView];
    [backView addSubview:btnTab4];
    
    UIButton* btnTab5 = [[UIButton alloc] initWithFrame:CGRectMake(tabWidth*4+2, 3, tabWidth, 31)];
    btnTab5.tag = 4;
    [btnTab5 addTarget:self action:@selector(btnTabPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.tab5SView=[[UIImageView alloc] initWithFrame:CGRectMake(tabWidth*4+2, 3, tabWidth, 31)];
    [self.tab5SView setImage:[UIImage imageNamed:@"tb_missedalert_normal_button.png"]];
    [self.tab5SView setContentMode:UIViewContentModeScaleAspectFit];
    [backView addSubview:self.tab5SView];
    [backView addSubview:btnTab5];
    
    
    //Badge
    self.badgeView = [[UIView alloc] initWithFrame:CGRectMake(tabWidth*5 - 23 , 1, 19, 21)];
    self.badgeView.tag = 100;
    UIImageView *badgeBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.badgeView.bounds.size.width, self.badgeView.bounds.size.height)];
    badgeBackground.image = [UIImage imageNamed:@"tb_badge_background.png"];
    [self.badgeView addSubview:badgeBackground];
    [backView addSubview:self.badgeView];
    
    self.badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(tabWidth*5 - 23 , 1, 18, 18)];
    [self.badgeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.badgeLabel setFont:[UIFont fontWithName:@"Helvetica" size:9.0]];
    [self.badgeLabel setTextColor:[UIColor whiteColor]];
    self.badgeLabel.backgroundColor = [UIColor clearColor];
    self.badgeLabel.text =@"10";
    self.badgeLabel.tag = 101;
    [backView addSubview:self.badgeLabel];
    
    //////////// Selected Tab end
    
    self.tab1Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, tabWidth, 10)];
    [self.tab1Label setTextAlignment:NSTextAlignmentCenter];
    [self.tab1Label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9.0]];
    [self.tab1Label setTextColor:[UIColor whiteColor]];
    self.tab1Label.backgroundColor = [UIColor clearColor];
    self.tab1Label.text =@"About";
    [backView addSubview:self.tab1Label];
    
    
    self.tab2Label = [[UILabel alloc] initWithFrame:CGRectMake(tabWidth, 35, tabWidth, 10)];
    [self.tab2Label setTextAlignment:NSTextAlignmentCenter];
    [self.tab2Label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9.0]];
    [self.tab2Label setTextColor:[UIColor whiteColor]];
    self.tab2Label.backgroundColor = [UIColor clearColor];
    self.tab2Label.text = @"Cards";
    [backView addSubview:self.tab2Label];
    
    self.tab3Label = [[UILabel alloc] initWithFrame:CGRectMake(tabWidth*2, 35, tabWidth, 10)];
    [self.tab3Label setTextAlignment:NSTextAlignmentCenter];
    [self.tab3Label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9.0]];
    [self.tab3Label setTextColor:[UIColor whiteColor]];
    self.tab3Label.backgroundColor = [UIColor clearColor];
    self.tab3Label.text = @"Random";
    [backView addSubview:self.tab3Label];
    
    self.tab4Label = [[UILabel alloc] initWithFrame:CGRectMake(tabWidth*3, 35, tabWidth, 10)];
    [self.tab4Label setTextAlignment:NSTextAlignmentCenter];
    [self.tab4Label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9.0]];
    [self.tab4Label setTextColor:[UIColor whiteColor]];
    self.tab4Label.backgroundColor = [UIColor clearColor];
    self.tab4Label.text = @"Alert";
    [backView addSubview:self.tab4Label];
    
    self.tab5Label = [[UILabel alloc] initWithFrame:CGRectMake(tabWidth*4, 35, tabWidth, 10)];
    [self.tab5Label setTextAlignment:NSTextAlignmentCenter];
    [self.tab5Label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9.0]];
    [self.tab5Label setTextColor:[UIColor whiteColor]];
    self.tab5Label.backgroundColor = [UIColor clearColor];
    self.tab5Label.text = @"Missed Alerts";
    [backView addSubview:self.tab5Label];
    
    UIColor *c = [UIColor blackColor];
    backView.backgroundColor = c;
    
    /* if([[[UIDevice currentDevice] systemVersion] floatValue] <5.0f){
     [[self tabBar] insertSubview:backView atIndex:0];
     }else{
     [[self tabBar] insertSubview:backView atIndex:1];
     }*/
    [[self tabBar] addSubview:backView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBadge) name:@"showBadge" object:nil];
}

-(void)btnTabPressed:(UIButton*)sender{
    //	NSLog(@"tab %d", sender.tag);
    //    NSLog(@"%d", (int)[self selectedIndex]);
    
    if (sender.tag == 1){
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        appDelegate.isSelectedTab2 = 1;
    }

    if (sender.tag != [self selectedIndex]) {
        [self setSelectedIndex:sender.tag];
        [self setSelectedBgFromIndex:(int)sender.tag];
    }
    else{
        if (sender.tag == 1){
            [self setSelectedIndex:0];
            [self setSelectedIndex:sender.tag];
            
        }
        
        if (sender.tag == 2){
            [self setSelectedIndex:0];
            [self setSelectedIndex:sender.tag];
        }
    }
    
    //    CardsViewController *cardsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CardsView"];
    //    [self.navigationController popToViewController:cardsViewController animated:YES];
    
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    //   [self.navigationController popViewControllerAnimated:YES];
}
/**
 Set selected image and make animation acording
 */

-(void) setSelectedBgFromIndex:(int) index{
    //[UIView beginAnimations:@"" context:NULL];
    //[UIView setAnimationDelegate:self];
    //[UIView setAnimationDuration:0.3];
    
    [selectedTab setFrame:CGRectMake(tabWidth*index, 0, 80, 40)];
    
    [self.tab1SView setImage:[UIImage imageNamed:@"tb_about_normal_button.png"]];
    [self.tab2SView setImage:[UIImage imageNamed:@"tb_cards_normal_button.png"]];
    [self.tab3SView setImage:[UIImage imageNamed:@"tb_random_normal_button.png"]];
    [self.tab4SView setImage:[UIImage imageNamed:@"tb_alerts_normal_button.png"]];
    [self.tab5SView setImage:[UIImage imageNamed:@"tb_missedalert_normal_button.png"]];
    
    switch (index) {
        case 0:
            [self.tab1SView setImage:[UIImage imageNamed:@"tb_about_selected_button.png"]];
            break;
        case 1:
            [self.tab2SView setImage:[UIImage imageNamed:@"tb_cards_selected_button.png"]];
            break;
        case 2:
            [self.tab3SView setImage:[UIImage imageNamed:@"tb_random_selected_button.png"]];
            break;
        case 3:
            [self.tab4SView setImage:[UIImage imageNamed:@"tb_alerts_selected_button.png"]];
            break;
        case 4:
            [self.tab5SView setImage:[UIImage imageNamed:@"tb_missedalert_selected_button.png"]];
            break;
        default:
            break;
    }
    //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //[UIView commitAnimations];
    /*switch (index) {
     case 0:{
     [tab1SView setHidden:false];
     [tab2SView setHidden:true];
     [tab3SView setHidden:true];
     break;
     }
     case 1:{
     [tab1SView setHidden:true];
     [tab2SView setHidden:false];
     [tab3SView setHidden:true];
     break;
     }
     case 2:{
     [tab1SView setHidden:true];
     [tab2SView setHidden:true];
     [tab3SView setHidden:false];
     break;
     }
     default:
     break;
     }*/
    
    
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    [self setSelectedBgFromIndex:(int)self.selectedIndex];
    
}

#pragma mark showBadge
-(void) showBadge{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    int nBadge = appDelegate.nBadgeNumber;
    
    if (nBadge == 0) {
        self.badgeView.hidden = YES;
        self.badgeLabel.hidden = YES;
    }else{
        self.badgeView.hidden = NO;
        self.badgeLabel.hidden = NO;
        
        if (nBadge < 100)
            [self.badgeLabel setFont:[UIFont fontWithName:@"Helvetica" size:9.0]];
        else
            [self.badgeLabel setFont:[UIFont fontWithName:@"Helvetica" size:8.0]];
        
        self.badgeLabel.text =[NSString stringWithFormat:@"%d", nBadge];
    }
}

@end
