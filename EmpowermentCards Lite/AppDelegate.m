//
//  AppDelegate.m
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 16/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import "AppDelegate.h"
#import "SATabBarController.h"

@interface AppDelegate (){
    CardsModel *cardModel;
    
    NSDate *tempDate;
    int tempRepeat;
    int tempSound;
    int tempCategoryIndex;
    int tempCardIndex;
    
    //Just Received Alert Data
    NSDate *justDate;
    int justRepeat;
    int justSound;
    int justCategoryIndex;
    int justCardIndex;
    
    bool allowNotif;
    bool allowsSound;
    bool allowsBadge;
    bool allowsAlert;
    
    int nSetAlert;
}

@end

@implementation AppDelegate

static AppDelegate * sharedDelegate = nil;
+ (AppDelegate *) sharedAppDelegate{
    if (sharedDelegate == nil)
        sharedDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    return sharedDelegate;
}

- (NSString *) storyboardName{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){ //iPad
        _nDeviceType = 3;
        return @"Main_iPad";
    }else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        if (iOSDeviceScreenSize.height == 480){ //iphone 4
            _nDeviceType = 2;
            return @"Main_iPhone4";
        }else{
            _nDeviceType = 1;
            return @"Main";
        }
    }
    
    return @"Main";
}

#pragma mark initStoryboard
- (void) initStoryboard{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDelegate] storyboardName] bundle:nil];
    
    RootNavi *viewController = (RootNavi *)[storyboard instantiateViewControllerWithIdentifier:@"RootNavi"];
    self.window.rootViewController = viewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _bPaid = 0;
    
    cardModel = [[CardsModel alloc] initCardsData];
    
    _arrCardImages = cardModel.arrCardImages;
    _arrCardContents = cardModel.arrCardContents;
    
    [self initStoryboard];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    _showBadgeNumber = (int)application.applicationIconBadgeNumber;
    
    application.applicationIconBadgeNumber = 0;
    
    _arrDate = [[NSMutableArray alloc] init];
    _arrRepeat = [[NSMutableArray alloc] init];
    _arrSound = [[NSMutableArray alloc] init];
    _arrCategoryIndex = [[NSMutableArray alloc] init];
    _arrCardIndex = [[NSMutableArray alloc] init];
    
    _arrReceivedDate = [[NSMutableArray alloc] init];
    _arrReceivedRepeat = [[NSMutableArray alloc] init];
    _arrReceivedSound = [[NSMutableArray alloc] init];
    _arrReceivedCategoryIndex  = [[NSMutableArray alloc] init];
    _arrReceivedCardIndex = [[NSMutableArray alloc] init];
    
    _nBadgeNumber = 0;
    
    nSetAlert  = 0;
    _repeatPickerData = [[NSArray alloc] initWithObjects:@"Once only", @"Every Day", @"Every Week", @"Every Month", nil];
    _soundPickerData = [[NSArray alloc] initWithObjects:@"System default", @"Alarm", @"Low power", @"Mail sent", @"Short high", nil];
    
    [self getAllAlerts];
    [self getAllReceivedAlerts];
    [self orderReivedAlerts];
    
    if (_foreground == 1){
        
        int nIndex = (int)self.arrReceivedDate.count-1;
        if ([[_arrReceivedRepeat objectAtIndex:nIndex] integerValue] != 0)
        {
            [self removeReceivedAlertWithDate:(NSDate *)[_arrReceivedDate objectAtIndex:nIndex]
                                      sRepeat:(int)[[_arrReceivedRepeat objectAtIndex:nIndex] intValue]
                                       sSound:(int)[[_arrReceivedSound objectAtIndex:nIndex] intValue]
                               sCategoryIndex:(int)[[_arrReceivedCategoryIndex objectAtIndex:nIndex] intValue]
                                   sCardIndex:(int)[[_arrReceivedCardIndex objectAtIndex:nIndex] intValue]];
        }
        
        SATabBarController *tabController = (SATabBarController *)self.window.rootViewController;
        [tabController setSelectedIndex:2];
        [tabController setSelectedBgFromIndex:2];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showBadge" object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    justDate = nil;
    justRepeat = 0;
    justSound = 0;
    justCategoryIndex = 0;
    justCardIndex = 0;
    
    if (notification != nil){
        
        application.applicationIconBadgeNumber = 0;
        
        //        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"You have scheduled a card to be viewed at this time" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        //        [alertView show];
        
        NSDictionary *arrIndex = notification.userInfo;
        int nIndex = (int)[[arrIndex objectForKey:@"AlertIndex"] integerValue];
        
        if (nIndex >= _arrDate.count)
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[_arrDate objectAtIndex:nIndex] forKey:@"endDate"];
            [userDefaults synchronize];
            
            return;
        }
        
        NSDictionary *userInfo = notification.userInfo;
        tempDate = [NSDate date];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy"];
        NSString *currentYear = [dateformatter stringFromDate:tempDate];
        
        [dateformatter setDateFormat:@"MM"];
        NSString *currentMonth = [dateformatter stringFromDate:tempDate];
        
        [dateformatter setDateFormat:@"dd"];
        NSString *currentDay = [dateformatter stringFromDate:tempDate];
        
        int sRepeat = [[userInfo objectForKey:@"Repeat"] intValue];
        int sSound = [[userInfo objectForKey:@"Sound"] intValue];
        int sCategoryIndex = [[userInfo objectForKey:@"Category"] intValue];
        int sCardIndex = [[userInfo objectForKey:@"Card"] intValue];
        
        
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        NSDate *cDate = [df dateFromString:[userInfo objectForKey:@"Date"]];
        
        [dateformatter setDateFormat:@"HH"];
        NSString *tempHour = [dateformatter stringFromDate:cDate];
        
        [dateformatter setDateFormat:@"mm"];
        NSString *tempMinute = [dateformatter stringFromDate:cDate];
        
        [dateformatter setDateFormat:@"ss"];
        NSString *tempSecond = [dateformatter stringFromDate:cDate];
        
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        dateComponents.year = [currentYear intValue];
        dateComponents.month = [currentMonth intValue];
        dateComponents.day = [currentDay intValue];
        dateComponents.hour = [tempHour intValue];
        dateComponents.minute = [tempMinute intValue];
        dateComponents.second = [tempSecond intValue];
        
        NSDate *ttDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
        
        if (![self searchReceivedAlertWithDate:ttDate sRepeat:sRepeat sSound:sSound sCategoryIndex:sCategoryIndex sCardIndex:sCardIndex]){
            
            [self addReceivedAlertWithDate:ttDate
                                   sRepeat:sRepeat
                                    sSound:sSound
                            sCategoryIndex:sCategoryIndex
                                sCardIndex:sCardIndex];
            
            //Once Only
            if ([[_arrRepeat objectAtIndex:nIndex] integerValue] == 0){
                [self removeAlertWithDate:cDate
                                  sRepeat:sRepeat
                                   sSound:sSound
                           sCategoryIndex:sCategoryIndex
                               sCardIndex:sCardIndex];
            }
        }
        
        _foreground = 1;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showBadge" object:nil];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:ttDate forKey:@"endDate"];
        [userDefaults synchronize];
        
        justDate = ttDate;
        justRepeat = sRepeat;
        justSound = sSound;
        justCategoryIndex = sCategoryIndex;
        justCardIndex = sCardIndex;
    }
}

#pragma mark Alerts Methods
- (void) getAllAlerts{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *tempArrDate, *tempArrRepeat, *tempArrSound, *tempArrCategoryIndex, *tempArrCardIndex;
    
    NSString *num = (NSString *)[userDefaults objectForKey:@"BadgeNumber"];
    if (![num isKindOfClass:[NSString class]]){
        [userDefaults setObject:@"0" forKey:@"BadgeNumber"];
        [userDefaults synchronize];
        num = @"0";
    }
    _nBadgeNumber = (int)[num integerValue];
    
    NSDate *userDate = (NSDate *)[userDefaults objectForKey:@"endDate"];
    if (![userDate isKindOfClass:[NSDate class]]){
        [userDefaults setObject:[NSDate date] forKey:@"endDate"];
        [userDefaults synchronize];
        userDate = [NSDate date];
    }
    _endDate = userDate;
    
    //Date
    tempArrDate = [userDefaults arrayForKey:@"DateArray"];
    if (![tempArrDate isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"DateArray"];
        [userDefaults synchronize];
        tempArrDate = [[NSArray alloc] init];
    }
    
    //Repeat
    tempArrRepeat = [userDefaults arrayForKey:@"RepeatArray"];
    if (![tempArrRepeat isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"RepeatArray"];
        [userDefaults synchronize];
        tempArrRepeat = [[NSArray alloc] init];
    }
    
    //Sound
    tempArrSound = [userDefaults arrayForKey:@"SoundArray"];
    if (![tempArrSound isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"SoundArray"];
        [userDefaults synchronize];
        tempArrSound = [[NSArray alloc] init];
    }
    
    //CategoryIndex
    tempArrCategoryIndex = [userDefaults arrayForKey:@"CategoryArray"];
    if (![tempArrCategoryIndex isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"CategoryArray"];
        [userDefaults synchronize];
        tempArrCategoryIndex = [[NSArray alloc] init];
    }
    
    //CardIndex
    tempArrCardIndex = [userDefaults arrayForKey:@"CardArray"];
    if (![tempArrCardIndex isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"CardArray"];
        [userDefaults synchronize];
        tempArrCardIndex = [[NSArray alloc] init];
    }
    
    for (int i=0; i<tempArrDate.count; i++)
    {
        [_arrDate addObject:(NSDate *)[tempArrDate objectAtIndex:i]];
        [_arrRepeat addObject:(NSNumber *)[tempArrRepeat objectAtIndex:i]];
        [_arrSound addObject:(NSNumber *)[tempArrSound objectAtIndex:i]];
        [_arrCategoryIndex addObject:(NSNumber *)[tempArrCategoryIndex objectAtIndex:i]];
        [_arrCardIndex addObject:(NSNumber *)[tempArrCardIndex objectAtIndex:i]];
    }
    
}

- (BOOL) searchAlertWithDate:(NSDate*)sDate
                     sRepeat:(int)sRepeat
                      sSound:(int)sSound
              sCategoryIndex:(int)sCategoryIndex
                  sCardIndex:(int)sCardIndex{
    for (int i=0; i<_arrDate.count; i++){
        tempDate = [_arrDate objectAtIndex:i];
        tempRepeat = (int)[[_arrRepeat objectAtIndex:i] integerValue];
        tempSound = (int)[[_arrSound objectAtIndex:i] integerValue];
        tempCategoryIndex = (int)[[_arrCategoryIndex objectAtIndex:i] integerValue];
        tempCardIndex = (int)[[_arrCardIndex objectAtIndex:i] integerValue];
        
        if ([tempDate compare:sDate] == NSOrderedSame &&
            tempRepeat == sRepeat &&
            tempSound == sSound &&
            tempCategoryIndex == sCategoryIndex &&
            tempCardIndex == sCardIndex){
            return TRUE;
        }
    }
    return FALSE;
}

- (void) addAlertWithDate:(NSDate*)sDate
                  sRepeat:(int)sRepeat
                   sSound:(int)sSound
           sCategoryIndex:(int)sCategoryIndex
               sCardIndex:(int)sCardIndex{
    if (![self searchAlertWithDate:sDate sRepeat:sRepeat sSound:sSound sCategoryIndex:sCategoryIndex sCardIndex:sCardIndex]){
        [_arrDate addObject:sDate];
        [_arrRepeat addObject:[NSNumber numberWithInt:sRepeat]];
        [_arrSound addObject:[NSNumber numberWithInt:sSound]];
        [_arrCategoryIndex addObject:[NSNumber numberWithInt:sCategoryIndex]];
        [_arrCardIndex addObject:[NSNumber numberWithInt:sCardIndex]];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[NSArray arrayWithArray:_arrDate] forKey:@"DateArray"];
        [userDefaults setObject:[NSArray arrayWithArray:_arrRepeat] forKey:@"RepeatArray"];
        [userDefaults setObject:[NSArray arrayWithArray:_arrSound] forKey:@"SoundArray"];
        [userDefaults setObject:[NSArray arrayWithArray:_arrCategoryIndex] forKey:@"CategoryArray"];
        [userDefaults setObject:[NSArray arrayWithArray:_arrCardIndex] forKey:@"CardArray"];
        [userDefaults synchronize];
    }
    
    // Set Notifications
    [self setNotifications];
}

- (void) removeAlertWithDate:(NSDate*)sDate
                     sRepeat:(int)sRepeat
                      sSound:(int)sSound
              sCategoryIndex:(int)sCategoryIndex
                  sCardIndex:(int)sCardIndex{
    int nCurrentIndex = -1;
    
    if ([self searchAlertWithDate:sDate sRepeat:sRepeat sSound:sSound sCategoryIndex:sCategoryIndex sCardIndex:sCardIndex]){
        for (int i=0; i<_arrDate.count; i++){
            tempDate = [_arrDate objectAtIndex:i];
            tempRepeat = (int)[[_arrRepeat objectAtIndex:i] integerValue];
            tempSound = (int)[[_arrSound objectAtIndex:i] integerValue];
            tempCategoryIndex = (int)[[_arrCategoryIndex objectAtIndex:i] integerValue];
            tempCardIndex = (int)[[_arrCardIndex objectAtIndex:i] integerValue];
            
            if ([tempDate compare:sDate] == NSOrderedSame &&
                tempRepeat == sRepeat &&
                tempSound == sSound &&
                tempCategoryIndex == sCategoryIndex &&
                tempCardIndex == sCardIndex){
                nCurrentIndex = i;
            }
        }
        
        if (nCurrentIndex != -1){
            [_arrDate removeObjectAtIndex:nCurrentIndex];
            [_arrRepeat removeObjectAtIndex:nCurrentIndex];
            [_arrSound removeObjectAtIndex:nCurrentIndex];
            [_arrCategoryIndex removeObjectAtIndex:nCurrentIndex];
            [_arrCardIndex removeObjectAtIndex:nCurrentIndex];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[NSArray arrayWithArray:_arrDate] forKey:@"DateArray"];
            [userDefaults setObject:[NSArray arrayWithArray:_arrRepeat] forKey:@"RepeatArray"];
            [userDefaults setObject:[NSArray arrayWithArray:_arrSound] forKey:@"SoundArray"];
            [userDefaults setObject:[NSArray arrayWithArray:_arrCategoryIndex] forKey:@"CategoryArray"];
            [userDefaults setObject:[NSArray arrayWithArray:_arrCardIndex] forKey:@"CardArray"];
            [userDefaults synchronize];
        }
        
    }
    
    [self setNotifications];
}

#pragma mark Received Alerts Methods
- (void) getAllReceivedAlerts{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *tempArrDate, *tempArrRepeat, *tempArrSound, *tempArrCategoryIndex, *tempArrCardIndex;
    
    //Received Date
    tempArrDate = [userDefaults arrayForKey:@"ReceivedDateArray"];
    if (![tempArrDate isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"ReceivedDateArray"];
        [userDefaults synchronize];
        tempArrDate = [[NSArray alloc] init];
    }
    
    //Received Repeat
    tempArrRepeat = [userDefaults arrayForKey:@"ReceivedRepeatArray"];
    if (![tempArrRepeat isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"ReceivedRepeatArray"];
        [userDefaults synchronize];
        tempArrRepeat = [[NSArray alloc] init];
    }
    
    //Received Sound
    tempArrSound = [userDefaults arrayForKey:@"ReceivedSoundArray"];
    if (![tempArrSound isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"ReceivedSoundArray"];
        [userDefaults synchronize];
        tempArrSound = [[NSArray alloc] init];
    }
    
    //Received CategoryIndex
    tempArrCategoryIndex = [userDefaults arrayForKey:@"ReceivedCategoryArray"];
    if (![tempArrCategoryIndex isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"ReceivedCategoryArray"];
        [userDefaults synchronize];
        tempArrCategoryIndex = [[NSArray alloc] init];
    }
    
    //Received CardIndex
    tempArrCardIndex = [userDefaults arrayForKey:@"ReceivedCardArray"];
    if (![tempArrCardIndex isKindOfClass:[NSArray class]]) {
        [userDefaults setObject:[[NSArray alloc] init] forKey:@"ReceivedCardArray"];
        [userDefaults synchronize];
        tempArrCardIndex = [[NSArray alloc] init];
    }
    
    for (int i=0; i<tempArrDate.count; i++)
    {
        [_arrReceivedDate addObject:(NSDate *)[tempArrDate objectAtIndex:i]];
        [_arrReceivedRepeat addObject:(NSNumber *)[tempArrRepeat objectAtIndex:i]];
        [_arrReceivedSound addObject:(NSNumber *)[tempArrSound objectAtIndex:i]];
        [_arrReceivedCategoryIndex addObject:(NSNumber *)[tempArrCategoryIndex objectAtIndex:i]];
        [_arrReceivedCardIndex addObject:(NSNumber *)[tempArrCardIndex objectAtIndex:i]];
    }
    
    _nBadgeNumber = (int)_arrReceivedDate.count;
}

- (BOOL) searchReceivedAlertWithDate:(NSDate*)sDate
                             sRepeat:(int)sRepeat
                              sSound:(int)sSound
                      sCategoryIndex:(int)sCategoryIndex
                          sCardIndex:(int)sCardIndex{
    for (int i=0; i<_arrReceivedDate.count; i++){
        tempDate = [_arrReceivedDate objectAtIndex:i];
        tempRepeat = (int)[[_arrReceivedRepeat objectAtIndex:i] integerValue];
        tempSound = (int)[[_arrReceivedSound objectAtIndex:i] integerValue];
        tempCategoryIndex = (int)[[_arrReceivedCategoryIndex objectAtIndex:i] integerValue];
        tempCardIndex = (int)[[_arrReceivedCardIndex objectAtIndex:i] integerValue];
        
        if ([tempDate compare:sDate] == NSOrderedSame &&
            tempRepeat == sRepeat &&
            tempSound == sSound &&
            tempCategoryIndex == sCategoryIndex &&
            tempCardIndex == sCardIndex){
            return TRUE;
        }
    }
    return FALSE;
}

- (void) addReceivedAlertWithDate:(NSDate*)sDate
                          sRepeat:(int)sRepeat
                           sSound:(int)sSound
                   sCategoryIndex:(int)sCategoryIndex
                       sCardIndex:(int)sCardIndex{
    if (![self searchReceivedAlertWithDate:sDate sRepeat:sRepeat sSound:sSound sCategoryIndex:sCategoryIndex sCardIndex:sCardIndex]){
        [_arrReceivedDate addObject:sDate];
        [_arrReceivedRepeat addObject:[NSNumber numberWithInt:sRepeat]];
        [_arrReceivedSound addObject:[NSNumber numberWithInt:sSound]];
        [_arrReceivedCategoryIndex addObject:[NSNumber numberWithInt:sCategoryIndex]];
        [_arrReceivedCardIndex addObject:[NSNumber numberWithInt:sCardIndex]];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedDate] forKey:@"ReceivedDateArray"];
        [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedRepeat] forKey:@"ReceivedRepeatArray"];
        [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedSound] forKey:@"ReceivedSoundArray"];
        [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedCategoryIndex] forKey:@"ReceivedCategoryArray"];
        [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedCardIndex] forKey:@"ReceivedCardArray"];
        [userDefaults synchronize];
        
        
        //Badge
        _nBadgeNumber++;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", _nBadgeNumber] forKey:@"BadgeNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showBadge" object:nil];
    }
}

- (void) removeReceivedAlertWithDate:(NSDate*)sDate
                             sRepeat:(int)sRepeat
                              sSound:(int)sSound
                      sCategoryIndex:(int)sCategoryIndex
                          sCardIndex:(int)sCardIndex{
    int nCurrentIndex = -1;
    
    if ([self searchReceivedAlertWithDate:sDate sRepeat:sRepeat sSound:sSound sCategoryIndex:sCategoryIndex sCardIndex:sCardIndex]){
        for (int i=0; i<_arrReceivedDate.count; i++){
            tempDate = [_arrReceivedDate objectAtIndex:i];
            tempRepeat = (int)[[_arrReceivedRepeat objectAtIndex:i] integerValue];
            tempSound = (int)[[_arrReceivedSound objectAtIndex:i] integerValue];
            tempCategoryIndex = (int)[[_arrReceivedCategoryIndex objectAtIndex:i] integerValue];
            tempCardIndex = (int)[[_arrReceivedCardIndex objectAtIndex:i] integerValue];
            
            if ([tempDate compare:sDate] == NSOrderedSame &&
                tempRepeat == sRepeat &&
                tempSound == sSound &&
                tempCategoryIndex == sCategoryIndex &&
                tempCardIndex == sCardIndex){
                nCurrentIndex = i;
            }
        }
        
        if (nCurrentIndex != -1){
            [_arrReceivedDate removeObjectAtIndex:nCurrentIndex];
            [_arrReceivedRepeat removeObjectAtIndex:nCurrentIndex];
            [_arrReceivedSound removeObjectAtIndex:nCurrentIndex];
            [_arrReceivedCategoryIndex removeObjectAtIndex:nCurrentIndex];
            [_arrReceivedCardIndex removeObjectAtIndex:nCurrentIndex];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedDate] forKey:@"ReceivedDateArray"];
            [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedRepeat] forKey:@"ReceivedRepeatArray"];
            [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedSound] forKey:@"ReceivedSoundArray"];
            [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedCategoryIndex] forKey:@"ReceivedCategoryArray"];
            [userDefaults setObject:[NSArray arrayWithArray:_arrReceivedCardIndex] forKey:@"ReceivedCardArray"];
            [userDefaults synchronize];
            
            //Badge
            if (_nBadgeNumber > 0)
                _nBadgeNumber--;
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", _nBadgeNumber] forKey:@"BadgeNumber"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showBadge" object:nil];
        }
        
    }
    
    //    [self setNotifications];
}

#pragma mark

#pragma mark saveNotification
- (void) setNotifications{
    
    //Remove all notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //Set all notifications
    for (int i=0; i<_arrDate.count; i++){
        [self saveNotificationWithIndex:i];
    }
}

- (void) saveNotificationWithIndex:(int) nIndex{
    nSetAlert = 1;
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    [self setNotificationTypesAllowed];
    if (notification)
    {
        if (allowNotif)
        {
            notification.fireDate = [_arrDate objectAtIndex:nIndex];
            notification.timeZone = [NSTimeZone defaultTimeZone];
            switch ([[_arrRepeat objectAtIndex:nIndex] integerValue]) {
                case 0:
                    notification.repeatInterval = 0;
                    break;
                case 1:
                    notification.repeatInterval = NSCalendarUnitDay;
                    break;
                case 2:
                    notification.repeatInterval = NSCalendarUnitWeekOfYear;
                    break;
                case 3:
                    notification.repeatInterval = NSCalendarUnitMonth;
                    break;
                default:
                    notification.repeatInterval = 0;
                    break;
            }
        }
        if (allowsAlert)
        {
            if (_bPaid == 0)
                notification.alertBody = @"You have a card to view";
            else
                notification.alertBody = @" You have a card to view";
        }
        if (allowsBadge)
        {
            notification.applicationIconBadgeNumber = 1;
        }
        if (allowsSound)
        {
            switch ([[_arrSound objectAtIndex:nIndex] integerValue]) {
                case 0:
                    notification.soundName = UILocalNotificationDefaultSoundName;
                    break;
                case 1:
                    notification.soundName = @"alarm.caf";
                    break;
                case 2:
                    notification.soundName = @"low_power.caf";
                    break;
                case 3:
                    notification.soundName = @"mail_sent.caf";
                    break;
                case 4:
                    notification.soundName = @"short_low_high.caf";
                    break;
                default:
                    notification.soundName = UILocalNotificationDefaultSoundName;
                    break;
            }
        }
        
        NSDictionary *infoDict = [[NSDictionary alloc] init];
        NSString *strAlertIndex = [NSString stringWithFormat:@"%d", nIndex];
        NSDate *cDate = [_arrDate objectAtIndex:nIndex];
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        NSString *strDate = [df stringFromDate:cDate];
        
        NSNumber *numberRepeat = [_arrRepeat objectAtIndex:nIndex];
        NSString *strRepeat = [numberRepeat stringValue];
        NSNumber *numberSound = [_arrRepeat objectAtIndex:nIndex];
        NSString *strSound = [numberSound stringValue];
        NSNumber *numberCategory = [_arrCategoryIndex objectAtIndex:nIndex];
        NSString *strCategory = [numberCategory stringValue];
        NSNumber *numberCard = [_arrCardIndex objectAtIndex:nIndex];
        NSString *strCard = [numberCard stringValue];
        
        infoDict = [NSDictionary dictionaryWithObjects:@[strAlertIndex, strDate, strRepeat, strSound, strCategory, strCard] forKeys:@[@"AlertIndex", @"Date", @"Repeat", @"Sound", @"Category", @"Card"]];
        //        [infoDict setValue:[NSString stringWithFormat:@"%d", nIndex] forKey:@"AlertIndex"];
        //        [infoDict setValue:[_arrDate objectAtIndex:nIndex] forKey:@"Date"];
        //        [infoDict setValue:[_arrRepeat objectAtIndex:nIndex] forKey:@"Repeat"];
        //        [infoDict setValue:[_arrSound objectAtIndex:nIndex] forKey:@"Sound" ];
        //        [infoDict setValue:[_arrCategoryIndex objectAtIndex:nIndex] forKey:@"Category"];
        //        [infoDict setValue:[_arrCardIndex objectAtIndex:nIndex] forKey:@"Card"];
        
        notification.userInfo = infoDict;
        
        // this will schedule the notification to fire at the fire date
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        // this will fire the notification right away, it will still also fire at the date we set
        //        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        notification = nil;
    }
    
    // we're creating a string of the date so we can log the time the notif is supposed to fire
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-yyy hh:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
    NSString *notifDate = [formatter stringFromDate:[_arrDate objectAtIndex:nIndex]];
    NSLog(@"%s: fire time = %@", __PRETTY_FUNCTION__, notifDate);
}

- (void)setNotificationTypesAllowed
{
    NSLog(@"%s:", __PRETTY_FUNCTION__);
    // get the current notification settings
    UIUserNotificationSettings *currentSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    allowNotif = (currentSettings.types != UIUserNotificationTypeNone);
    allowsSound = (currentSettings.types & UIUserNotificationTypeSound) != 0;
    allowsBadge = (currentSettings.types & UIUserNotificationTypeBadge) != 0;
    allowsAlert = (currentSettings.types & UIUserNotificationTypeAlert) != 0;
    
}

#pragma mark Order Received Alerts
- (void) orderReivedAlerts{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-dd-MM HH:mm:ss"];
    
    [formatter setDateFormat:@"YYYY"];
    NSString *currentYear = [NSString stringWithFormat:@"%@", [formatter stringFromDate:currentDate]];
    
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth = [NSString stringWithFormat:@"%@", [formatter stringFromDate:currentDate]];
    
    [formatter setDateFormat:@"dd"];
    NSString *currentDay = [NSString stringWithFormat:@"%@", [formatter stringFromDate:currentDate]];
    
    //    [formatter setDateFormat:@"HH"];
    //    NSString *currentHour = [NSString stringWithFormat:@"%@", [formatter stringFromDate:currentDate]];
    //
    //    [formatter setDateFormat:@"mm"];
    //    NSString *currentMinute = [NSString stringWithFormat:@"%@", [formatter stringFromDate:currentDate]];
    //
    //    [formatter setDateFormat:@"ss"];
    //    NSString *currentSecond = [NSString stringWithFormat:@"%@", [formatter stringFromDate:currentDate]];
    
    [formatter setDateFormat:@"e"];
    NSString *currentWeekDay = [NSString stringWithFormat:@"%@", [formatter stringFromDate:currentDate]];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = [currentYear intValue];
    dateComponents.month = [currentMonth intValue];
    dateComponents.day = [currentDay intValue];
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    
    NSDate *startDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    
    if (_arrDate.count == 0 && _arrReceivedDate.count == 0) {
        _endDate = startDate;
        return;
    }
    
    if ([startDate compare:_endDate] != NSOrderedDescending){
        startDate = _endDate;
    }
    
    //Get Once only
    int i = 0;
    while (i<_arrDate.count) {
        if ([[_arrRepeat objectAtIndex:i] intValue] == 0){
            tempDate = (NSDate *)[_arrDate objectAtIndex:i];
            if ([tempDate compare:startDate] != NSOrderedAscending && [tempDate compare:currentDate] != NSOrderedDescending){
                [self addReceivedAlertWithDate:[_arrDate objectAtIndex:i]
                                       sRepeat:(int)[[_arrRepeat objectAtIndex:i] integerValue]
                                        sSound:(int)[[_arrSound objectAtIndex:i] integerValue]
                                sCategoryIndex:(int)[[_arrCategoryIndex objectAtIndex:i] integerValue]
                                    sCardIndex:(int)[[_arrCardIndex objectAtIndex:i] integerValue]];
                
                [self removeAlertWithDate:[_arrDate objectAtIndex:i]
                                  sRepeat:(int)[[_arrRepeat objectAtIndex:i] integerValue]
                                   sSound:(int)[[_arrSound objectAtIndex:i] integerValue]
                           sCategoryIndex:(int)[[_arrCategoryIndex objectAtIndex:i] integerValue]
                               sCardIndex:(int)[[_arrCardIndex objectAtIndex:i] integerValue]];
            }
            i++;
        }else{
            i++;
        }
    }
    
    //Every Day
    i = 0;
    while (i<_arrDate.count) {
        if ([[_arrRepeat objectAtIndex:i] intValue] == 1){
            tempDate = (NSDate *)[_arrDate objectAtIndex:i];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            //            [formatter setDateFormat:@"YYYY"];
            //            NSString *tempYear = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            //
            //            [formatter setDateFormat:@"MM"];
            //            NSString *tempMonth = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            //
            //            [formatter setDateFormat:@"dd"];
            //            NSString *tempDay = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            //
            [formatter setDateFormat:@"HH"];
            NSString *tempHour = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"mm"];
            NSString *tempMinute = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"ss"];
            NSString *tempSecond = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"e"];
            //            NSString *tempWeekDay = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            dateComponents.year = [currentYear intValue];
            dateComponents.month = [currentMonth intValue];
            dateComponents.day = [currentDay intValue];
            dateComponents.hour = [tempHour intValue];
            dateComponents.minute = [tempMinute intValue];
            dateComponents.second = [tempSecond intValue];
            
            NSDate *ttDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
            
            if ([ttDate compare:startDate] != NSOrderedAscending && [ttDate compare:currentDate] != NSOrderedDescending){
                [self addReceivedAlertWithDate:ttDate
                                       sRepeat:(int)[[_arrRepeat objectAtIndex:i] integerValue]
                                        sSound:(int)[[_arrSound objectAtIndex:i] integerValue]
                                sCategoryIndex:(int)[[_arrCategoryIndex objectAtIndex:i] integerValue]
                                    sCardIndex:(int)[[_arrCardIndex objectAtIndex:i] integerValue]];
            }
            i++;
        }else{
            i++;
        }
    }
    
    //Every week
    i = 0;
    while (i<_arrDate.count) {
        if ([[_arrRepeat objectAtIndex:i] intValue] == 2){
            tempDate = (NSDate *)[_arrDate objectAtIndex:i];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            //            [formatter setDateFormat:@"YYYY"];
            //            NSString *tempYear = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            //
            //            [formatter setDateFormat:@"MM"];
            //            NSString *tempMonth = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            //
            //            [formatter setDateFormat:@"dd"];
            //            NSString *tempDay = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            //
            [formatter setDateFormat:@"HH"];
            NSString *tempHour = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"mm"];
            NSString *tempMinute = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"ss"];
            NSString *tempSecond = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"e"];
            NSString *tempWeekDay = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            dateComponents.year = [currentYear intValue];
            dateComponents.month = [currentMonth intValue];
            dateComponents.day = [currentDay intValue];
            dateComponents.hour = [tempHour intValue];
            dateComponents.minute = [tempMinute intValue];
            dateComponents.second = [tempSecond intValue];
            
            NSDate *ttDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
            
            if ([tempWeekDay isEqualToString:currentWeekDay] && [ttDate compare:startDate] != NSOrderedAscending && [ttDate compare:currentDate] != NSOrderedDescending){
                [self addReceivedAlertWithDate:ttDate
                                       sRepeat:(int)[[_arrRepeat objectAtIndex:i] integerValue]
                                        sSound:(int)[[_arrSound objectAtIndex:i] integerValue]
                                sCategoryIndex:(int)[[_arrCategoryIndex objectAtIndex:i] integerValue]
                                    sCardIndex:(int)[[_arrCardIndex objectAtIndex:i] integerValue]];
            }
            i++;
        }else{
            i++;
        }
    }
    
    //Every week
    i = 0;
    while (i<_arrDate.count) {
        if ([[_arrRepeat objectAtIndex:i] intValue] == 3){
            tempDate = (NSDate *)[_arrDate objectAtIndex:i];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            [formatter setDateFormat:@"YYYY"];
            //            NSString *tempYear = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"MM"];
            //            NSString *tempMonth = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"dd"];
            NSString *tempDay = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"HH"];
            NSString *tempHour = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"mm"];
            NSString *tempMinute = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"ss"];
            NSString *tempSecond = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            [formatter setDateFormat:@"e"];
            //            NSString *tempWeekDay = [NSString stringWithFormat:@"%@", [formatter stringFromDate:tempDate]];
            
            
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            dateComponents.year = [currentYear intValue];
            dateComponents.month = [currentMonth intValue];
            dateComponents.day = [tempDay intValue];
            dateComponents.hour = [tempHour intValue];
            dateComponents.minute = [tempMinute intValue];
            dateComponents.second = [tempSecond intValue];
            
            NSDate *ttDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
            
            if ([ttDate compare:startDate] != NSOrderedAscending && [ttDate compare:currentDate] != NSOrderedDescending){
                [self addReceivedAlertWithDate:ttDate
                                       sRepeat:(int)[[_arrRepeat objectAtIndex:i] integerValue]
                                        sSound:(int)[[_arrSound objectAtIndex:i] integerValue]
                                sCategoryIndex:(int)[[_arrCategoryIndex objectAtIndex:i] integerValue]
                                    sCardIndex:(int)[[_arrCardIndex objectAtIndex:i] integerValue]];
            }
            i++;
        }else{
            i++;
        }
    }
    
    //Order
    if (_arrReceivedDate.count > 2){
        for (int i=0; i<_arrReceivedDate.count-2; i++){
            for (int j=i+1; j<_arrReceivedDate.count-1; j++) {
                if ([_arrReceivedDate[j] compare:_arrReceivedDate[i]] == NSOrderedAscending){
                    NSDate *tDate = [_arrReceivedDate objectAtIndex:i];
                    NSNumber *tRepeat = [NSNumber numberWithInt:(int)[[_arrReceivedRepeat objectAtIndex:i] integerValue]];
                    NSNumber *tSound = [NSNumber numberWithInt:(int)[[_arrReceivedSound objectAtIndex:i] integerValue]];
                    NSNumber *tCategoryIndex = [NSNumber numberWithInt:(int)[[_arrReceivedCategoryIndex objectAtIndex:i] integerValue]];
                    NSNumber *tCardIndex = [NSNumber numberWithInt:(int)[[_arrReceivedCardIndex objectAtIndex:i] integerValue]];
                    
                    [_arrReceivedDate removeObjectAtIndex:i];
                    [_arrReceivedRepeat removeObjectAtIndex:i];
                    [_arrReceivedSound removeObjectAtIndex:i];
                    [_arrReceivedCategoryIndex removeObjectAtIndex:i];
                    [_arrReceivedCardIndex removeObjectAtIndex:i];
                    
                    [_arrReceivedDate insertObject:[_arrReceivedDate objectAtIndex:j-1] atIndex:i];
                    [_arrReceivedRepeat insertObject:[_arrReceivedRepeat objectAtIndex:j-1] atIndex:i];
                    [_arrReceivedSound insertObject:[_arrReceivedSound objectAtIndex:j-1] atIndex:i];
                    [_arrReceivedCategoryIndex insertObject:[_arrReceivedCategoryIndex objectAtIndex:j-1] atIndex:i];
                    [_arrReceivedCardIndex insertObject:[_arrReceivedCardIndex objectAtIndex:j-1] atIndex:i];
                    
                    [_arrReceivedDate removeObjectAtIndex:j];
                    [_arrReceivedRepeat removeObjectAtIndex:j];
                    [_arrReceivedSound removeObjectAtIndex:j];
                    [_arrReceivedCategoryIndex removeObjectAtIndex:j];
                    [_arrReceivedCardIndex removeObjectAtIndex:j];
                    
                    [_arrReceivedDate insertObject:tDate atIndex:j];
                    [_arrReceivedRepeat insertObject:tRepeat atIndex:j];
                    [_arrReceivedSound insertObject:tSound atIndex:j];
                    [_arrReceivedCategoryIndex insertObject:tCategoryIndex atIndex:j];
                    [_arrReceivedCardIndex insertObject:tCardIndex atIndex:j];
                    
                }
            }
        }
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:currentDate forKey:@"endDate"];
    [userDefaults synchronize];
    
}

@end
