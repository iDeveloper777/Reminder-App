//
//  SetAlertViewController.m
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 21/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import "SetAlertViewController.h"
#import "AppDelegate.h"

@interface SetAlertViewController (){
    
    NSMutableArray *arrCardImages;
    NSMutableArray *arrCardContents;
    
    int bPaid;
    
    AFPickerView *repeatPickerView;
    AFPickerView *soundPickerView;
    
    NSArray *repeatPickerData;
    NSArray *soundPickerData;
    
    int nRepeatIndex;
    int nSoundIndex;
    
    int pickerViewHeight;
    CGRect screenSize;
    
    int isShowRepeat;
    int isShowSound;
    
    NSDate *selectedDate;
    
    BOOL bSuccess;
}

@end

@implementation SetAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    arrCardImages = appDelegate.arrCardImages;
    arrCardContents = appDelegate.arrCardContents;
    
    bPaid = appDelegate.bPaid;
    
    bSuccess = FALSE;
    
    isShowRepeat = 0; isShowSound = 0;
    pickerViewHeight = 197;
    screenSize = [[UIScreen mainScreen] bounds];
    
    [self setLayoutPickerView];
    [self showTimePickerView];
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
- (BOOL) hidesBottomBarWhenPushed{
    return  YES;
}

#pragma mark setLayoutPickerView
- (void) setLayoutPickerView{
    repeatPickerData = [[NSArray alloc] initWithObjects:@"Once only", @"Every Day", @"Every Week", @"Every Month", nil];
    soundPickerData = [[NSArray alloc] initWithObjects:@"System default", @"Alarm", @"Low power", @"Mail sent", @"Short high", nil];
    
    repeatPickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(0, self.pickerUIView.bounds.size.height-pickerViewHeight, screenSize.size.width, pickerViewHeight)];
    repeatPickerView.dataSource = self;
    repeatPickerView.delegate = self;
    [repeatPickerView reloadData];
    [self.pickerUIView addSubview:repeatPickerView];
    self.pickerUIView.hidden = YES;
    repeatPickerView.hidden = YES;
    isShowRepeat = 0;
    
    isShowSound = 1;
    soundPickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(0, self.pickerUIView.bounds.size.height-pickerViewHeight, screenSize.size.width, pickerViewHeight)];
    soundPickerView.dataSource = self;
    soundPickerView.delegate = self;
    [soundPickerView reloadData];
    [self.pickerUIView addSubview:soundPickerView];
    self.pickerUIView.hidden = YES;
    soundPickerView.hidden = YES;
    isShowSound = 0;
}

#pragma mark showTimePickerView
- (void) showTimePickerView{

}


#pragma mark Buttons Events

- (IBAction)press_Back_Button:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)press_Save_Button:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDate *currentDate = [NSDate date];
    
    if ([selectedDate compare:currentDate] == NSOrderedDescending){//success
        if([appDelegate searchAlertWithDate:selectedDate sRepeat:nRepeatIndex sSound:nSoundIndex sCategoryIndex:_nIndex sCardIndex:_nCardIndex]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This alert already registerd." delegate:self cancelButtonTitle:@"Close." otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            bSuccess = TRUE;
            
            [appDelegate addAlertWithDate:selectedDate sRepeat:nRepeatIndex sSound:nSoundIndex sCategoryIndex:_nIndex sCardIndex:_nCardIndex];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert Notification set" message:@"You have successfully set an alert for this card." delegate:self cancelButtonTitle:@"Close." otherButtonTitles:nil, nil];
            [alertView show];
        }
            
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Time you have set has already passed. Please select another time of your alert." delegate:nil cancelButtonTitle:@"Close." otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)press_Repeat_Button:(id)sender {
    [self.pickerUIView  setFrame:CGRectMake(0, screenSize.size.height, self.pickerUIView.bounds.size.width, self.pickerUIView.bounds.size.height)];
    
    self.pickerUIView.hidden = NO; isShowRepeat = 1;
    repeatPickerView.hidden = NO;
    soundPickerView.hidden = YES; isShowSound = 0;
    
    CGRect viewFrame = self.pickerUIView.frame;
    viewFrame.origin.y -= self.pickerUIView.bounds.size.height;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    [self.pickerUIView setFrame:viewFrame];
    [UIView commitAnimations];

}

- (IBAction)press_Sound_Button:(id)sender {
    [self.pickerUIView  setFrame:CGRectMake(0, screenSize.size.height, self.pickerUIView.bounds.size.width, self.pickerUIView.bounds.size.height)];
    
    self.pickerUIView.hidden = NO; isShowSound = 1;
    soundPickerView.hidden = NO;
    repeatPickerView.hidden = YES; isShowRepeat = 0;
    
    CGRect viewFrame = self.pickerUIView.frame;
    viewFrame.origin.y -= self.pickerUIView.bounds.size.height;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    [self.pickerUIView setFrame:viewFrame];
    [UIView commitAnimations];

}


- (IBAction)actionCancel:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseIn animations:^{
        self.pickerUIView.hidden = YES;
    }
    completion:^(BOOL finished){
    }];
    
    repeatPickerView.hidden = YES; isShowRepeat = 0;
    soundPickerView.hidden = YES; isShowSound = 0;
}

- (IBAction)actionDone:(id)sender {
    
    [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseIn animations:^{
        self.pickerUIView.hidden = YES;
    }
    completion:^(BOOL finished){
    }];
    
    repeatPickerView.hidden = YES; isShowRepeat = 0;
    soundPickerView.hidden = YES; isShowSound = 0;
}

#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView
{
    if (isShowRepeat == 1)
        return [repeatPickerData count];
    
    if (isShowSound == 1)
        return [soundPickerData count];
    
    return [repeatPickerData count];
}

- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (isShowRepeat == 1)
        return [repeatPickerData objectAtIndex:row];
    
    if (isShowSound == 1)
        return [soundPickerData objectAtIndex:row];
    
    return [repeatPickerData objectAtIndex:row];
}

#pragma mark - AFPickerViewDelegate

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row
{
    if (isShowRepeat == 1)
        nRepeatIndex = (int) row;
    
    if (isShowSound == 1)
        nSoundIndex = (int) row;
}

#pragma mark DatePicker controll
- (IBAction)getSelectedDate:(id)sender{
    NSDate *date = [self.datePickerView date];
    
    selectedDate = date;
}

- (void) getCurrentDate{

    NSDate *date = [NSDate date];
  
    selectedDate = date;
}

#pragma mark AlertView
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == [alertView cancelButtonIndex] && bSuccess == TRUE)
        [self.navigationController popViewControllerAnimated:YES];
}


@end
