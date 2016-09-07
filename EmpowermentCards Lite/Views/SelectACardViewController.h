//
//  SelectACardViewController.h
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectACardViewController : UIViewController

@property (nonatomic, assign) int nIndex;

@property (weak, nonatomic) IBOutlet UIScrollView *svCards;

- (IBAction)press_Back_Button:(id)sender;
@end
