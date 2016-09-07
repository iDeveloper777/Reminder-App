//
//  SATabBar.h
//  CustomTabbar
//
//  Created by RIGEL NETWORKS PVT. LTD on 05/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SATabBarController : UITabBarController<UITabBarControllerDelegate> {
	
	IBOutlet UITabBar *saTabBar;
	UIImageView *tab1IView;
	UIImageView *tab2IView;
	UIImageView *tab3IView;
    UIImageView *tab4IView;
    UIImageView *tab5IView;
    
    UIImageView *tab1SView;
	UIImageView *tab2SView;
	UIImageView *tab3SView;
    UIImageView *tab4SView;
    UIImageView *tab5SView;
    
	UIView *selectedTab;
	UILabel *tab1Label;
	UILabel *tab2Label;
	UILabel *tab3Label;
    UILabel *tab4Label;
    UILabel *tab5Label;
	
    UIView *badgeView;
    UILabel *badgeLabel;
    
    CGFloat tabWidth;
    
}
@property(nonatomic, retain) UILabel *tab1Label;
@property(nonatomic, retain) UILabel *tab2Label;
@property(nonatomic, retain) UILabel *tab3Label;
@property(nonatomic, retain) UILabel *tab4Label;
@property(nonatomic, retain) UILabel *tab5Label;

@property(nonatomic, retain) UITabBar *saTabBar;
@property(nonatomic, retain) UIImageView *tab1IView;
@property(nonatomic, retain) UIImageView *tab2IView;
@property(nonatomic, retain) UIImageView *tab3IView;
@property(nonatomic, retain) UIImageView *tab4IView;
@property(nonatomic, retain) UIImageView *tab5IView;

@property(nonatomic, retain) UIImageView *tab1SView;
@property(nonatomic, retain) UIImageView *tab2SView;
@property(nonatomic, retain) UIImageView *tab3SView;
@property(nonatomic, retain) UIImageView *tab4SView;
@property(nonatomic, retain) UIImageView *tab5SView;

@property(nonatomic, retain) UIView *badgeView;
@property(nonatomic, retain) UILabel *badgeLabel;

-(void) setSelectedBgFromIndex:(int) index;

-(void) showBadge;


@end
