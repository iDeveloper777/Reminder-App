//
//  AppDelegate.h
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 16/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardsModel.h"
#import "AlertModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SATabBarController.h"
#import "RootNavi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign, nonatomic) int nDeviceType;

@property (nonatomic, assign) int bPaid;
@property (nonatomic, assign) int showBadgeNumber;
@property (nonatomic, assign) int foreground;
@property (nonatomic, assign) int isSelectedTab2;

@property (strong, nonatomic) NSArray *repeatPickerData;
@property (strong, nonatomic) NSArray *soundPickerData;

@property (strong, nonatomic) NSMutableArray *arrCardImages;
@property (strong, nonatomic) NSMutableArray *arrCardContents;

@property (strong, nonatomic) NSMutableArray *arrAlerts;

@property (strong, nonatomic) NSMutableArray *arrDate;
@property (strong, nonatomic) NSMutableArray *arrRepeat;
@property (strong, nonatomic) NSMutableArray *arrSound;
@property (strong, nonatomic) NSMutableArray *arrCategoryIndex;
@property (strong, nonatomic) NSMutableArray *arrCardIndex;

@property (strong, nonatomic) NSMutableArray *arrReceivedDate;
@property (strong, nonatomic) NSMutableArray *arrReceivedRepeat;
@property (strong, nonatomic) NSMutableArray *arrReceivedSound;
@property (strong, nonatomic) NSMutableArray *arrReceivedCategoryIndex;
@property (strong, nonatomic) NSMutableArray *arrReceivedCardIndex;

@property (nonatomic, assign)int nBadgeNumber;
@property (nonatomic, strong)NSDate *endDate;

- (void) getAllAlerts;
- (BOOL) searchAlertWithDate:(NSDate*)sDate
                     sRepeat:(int)sRepeat
                      sSound:(int)sSound
              sCategoryIndex:(int)sCategoryIndex
                  sCardIndex:(int)sCardIndex;
- (void) addAlertWithDate:(NSDate*)sDate
                  sRepeat:(int)sRepeat
                   sSound:(int)sSound
           sCategoryIndex:(int)sCategoryIndex
               sCardIndex:(int)sCardIndex;
- (void) removeAlertWithDate:(NSDate*)sDate
                     sRepeat:(int)sRepeat
                      sSound:(int)sSound
              sCategoryIndex:(int)sCategoryIndex
                  sCardIndex:(int)sCardIndex;
//Received Alerts
- (BOOL) searchReceivedAlertWithDate:(NSDate*)sDate
                             sRepeat:(int)sRepeat
                              sSound:(int)sSound
                      sCategoryIndex:(int)sCategoryIndex
                          sCardIndex:(int)sCardIndex;
- (void) addReceivedAlertWithDate:(NSDate*)sDate
                          sRepeat:(int)sRepeat
                           sSound:(int)sSound
                   sCategoryIndex:(int)sCategoryIndex
                       sCardIndex:(int)sCardIndex;
- (void) removeReceivedAlertWithDate:(NSDate*)sDate
                             sRepeat:(int)sRepeat
                              sSound:(int)sSound
                      sCategoryIndex:(int)sCategoryIndex
                          sCardIndex:(int)sCardIndex;

- (void) saveNotificationWithIndex:(int) nIndex;

+ (AppDelegate *) sharedAppDelegate;
- (NSString *) storyboardName;
@end

