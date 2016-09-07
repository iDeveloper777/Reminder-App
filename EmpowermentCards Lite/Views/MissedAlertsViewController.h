//
//  MissedAlertsViewController.h
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MissedAlertsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblAlert;
@property (weak, nonatomic) IBOutlet UITableView *alertsTableView;
@end
