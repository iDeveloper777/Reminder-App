//
//  SetAlertViewController.h
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 21/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFPickerView.h"

@interface SetAlertViewController : UIViewController <AFPickerViewDataSource, AFPickerViewDelegate, UIAlertViewDelegate>
@property (nonatomic, assign) int nIndex;
@property (nonatomic, assign) int nCardIndex;

- (IBAction)press_Back_Button:(id)sender;
- (IBAction)press_Save_Button:(id)sender;

- (IBAction)press_Repeat_Button:(id)sender;
- (IBAction)press_Sound_Button:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *pickerUIView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)actionCancel:(id)sender;
- (IBAction)actionDone:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *timePickUiView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

- (IBAction)getSelectedDate:(id)sender;


@end
