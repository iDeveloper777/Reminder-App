//
//  AlertsViewController.m
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import "AlertsViewController.h"
#import "AppDelegate.h"
#import "SelectedCardViewController.h"

@interface AlertsViewController (){
    AppDelegate *appDelegate;
    
    NSMutableArray *arrCardImages;
    NSMutableArray *arrCardContents;
 
    NSMutableArray *arrDate;
    NSMutableArray *arrRepeat;
    NSMutableArray *arrSound;
    NSMutableArray *arrCategoryIndex;
    NSMutableArray *arrCardIndex;
    
    int bEdit;
}

@end

@implementation AlertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    bEdit = 0;
    
    self.alertsTableView.hidden = NO;
    self.lblAlert.hidden = NO;
    
    [self getAllDatas];
    [self setLayout];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark getAllDatas
- (void) getAllDatas{
    arrCardImages = appDelegate.arrCardImages;
    arrCardContents = appDelegate.arrCardContents;
    
    arrDate = [[NSMutableArray alloc] init];
    arrRepeat = [[NSMutableArray alloc] init];
    arrSound = [[NSMutableArray alloc] init];
    arrCategoryIndex = [[NSMutableArray alloc] init];
    arrCardIndex = [[NSMutableArray alloc] init];
    
    for (int i=0; i<appDelegate.arrDate.count; i++)
    {
        [arrDate addObject:(NSDate *)[appDelegate.arrDate objectAtIndex:i]];
        [arrRepeat addObject:(NSNumber *)[appDelegate.arrRepeat objectAtIndex:i]];
        [arrSound addObject:(NSNumber *)[appDelegate.arrSound objectAtIndex:i]];
        [arrCategoryIndex addObject:(NSNumber *)[appDelegate.arrCategoryIndex objectAtIndex:i]];
        [arrCardIndex addObject:(NSNumber *)[appDelegate.arrCardIndex objectAtIndex:i]];
    }

}

#pragma mark setLayout
- (void) setLayout{
    if (appDelegate.arrDate.count == 0) {
        self.alertsTableView.hidden = YES;
        self.lblAlert.hidden = NO;
    }else{
        self.alertsTableView.hidden = NO;
        self.lblAlert.hidden = YES;
    }
    
    self.alertsTableView.backgroundColor = [UIColor clearColor];
    self.alertsTableView.separatorStyle = NO;
    [self.alertsTableView reloadData];
}

#pragma mark TableView Events
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrDate count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];

    int nWidth = self.alertsTableView.bounds.size.width;
    
    //background
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, nWidth, 90)];
    
    imageView.image = [UIImage imageNamed:@"alerts_cell_background.png"];
    imageView.tag = 0;
    [cell.contentView addSubview:imageView];
    
    //Card
    NSArray *arrCards = [arrCardImages objectAtIndex:[[arrCategoryIndex objectAtIndex:indexPath.row] integerValue]];
    NSString *imgName = [arrCards objectAtIndex:[[arrCardIndex objectAtIndex:indexPath.row] integerValue]];
    
    UIImageView *imgCard = [[UIImageView alloc] initWithFrame:CGRectMake(10 , 10, 50, 75)];
    
    imgCard.image = [UIImage imageNamed:imgName];
    imgCard.tag = 1;
    [cell.contentView addSubview:imgCard];
    if (bEdit == 1)
        imgCard.hidden = YES;
    else
        imgCard.hidden = NO;
    
    //Button(On)
    UIButton *btnOn = [[UIButton alloc] initWithFrame:CGRectMake(5, 15, 40, 40)];
    [btnOn setBackgroundImage:[UIImage imageNamed:@"alerts_On_button.png"] forState:UIControlStateNormal];
    [btnOn addTarget:self action:@selector(buttonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnOn.tag = 2000+indexPath.row;
    [cell.contentView addSubview:btnOn];
    if (bEdit == 1)
        btnOn.hidden = NO;
    else
        btnOn.hidden = YES;
    
    //Button(Off)
    UIButton *btnOff = [[UIButton alloc] initWithFrame:CGRectMake(5, 15, 40, 40)];
    [btnOff setBackgroundImage:[UIImage imageNamed:@"alerts_Off_button.png"] forState:UIControlStateNormal];
    [btnOff addTarget:self action:@selector(buttonOffClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnOff.tag = 3000+indexPath.row;
    [cell.contentView addSubview:btnOff];
    btnOff.hidden = YES;

    //CardContent
    NSArray *arrContents = [arrCardContents objectAtIndex:[[arrCategoryIndex objectAtIndex:indexPath.row] integerValue]];
    NSString *cardContent = [arrContents objectAtIndex:[[arrCardIndex objectAtIndex:indexPath.row] integerValue]];
    
    UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(70, 5, nWidth-80, 55)];
    contentTextView.backgroundColor = [UIColor clearColor];
    contentTextView.text = cardContent;
    contentTextView.scrollEnabled = NO;
    contentTextView.editable = NO;
    contentTextView.tag = 1000+indexPath.row;
    [contentTextView setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    singleTap.numberOfTapsRequired = 1;
    [contentTextView setUserInteractionEnabled:YES];
    [contentTextView addGestureRecognizer:singleTap];
    
    [cell.contentView addSubview:contentTextView];
    
    //Repeat - Date
    NSString *strRepeatDate;
    strRepeatDate = [appDelegate.repeatPickerData objectAtIndex:[[arrRepeat objectAtIndex:indexPath.row] integerValue]];
    
    NSDate *date = [arrDate objectAtIndex:indexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"E   dd:MM:yyyy   HH:mm"];
    strRepeatDate = [NSString stringWithFormat:@"%@ - %@", strRepeatDate, [formatter stringFromDate:date]];

    UILabel *lblRepeatDate = [[UILabel alloc] initWithFrame:CGRectMake(75, 60, nWidth-80, 20)];
    lblRepeatDate.text = strRepeatDate;
    lblRepeatDate.tag =3;
    [lblRepeatDate setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0]];
    [lblRepeatDate setTextColor:[UIColor grayColor]];
    [cell.contentView addSubview:lblRepeatDate];
    
    //Button(Delete)
    UIButton *btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(nWidth - 100, 28, 80, 36)];
    [btnDelete setBackgroundImage:[UIImage imageNamed:@"alerts_Delete_button.png"] forState:UIControlStateNormal];
    [btnDelete addTarget:self action:@selector(buttonDeleteClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnDelete.tag = 4000+indexPath.row;
    [cell.contentView addSubview:btnDelete];
    btnDelete.hidden = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelectedCardViewController *selectedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectedCardView"];

    selectedViewController.nIndex = (int)[[arrCategoryIndex objectAtIndex:indexPath.row] integerValue];
    selectedViewController.nCardIndex = (int)[[arrCardIndex objectAtIndex:indexPath.row] integerValue];
    
    [self.navigationController pushViewController:selectedViewController animated:YES];
}

#pragma mark tapGesture
- (void) tapGesture: (UIGestureRecognizer *) gestureRecognizer{
    UITextView *textView = (UITextView *)gestureRecognizer.view;
    int nIndex = (int)textView.tag - 1000;
    
    SelectedCardViewController *selectedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectedCardView"];
    
    selectedViewController.nIndex = (int)[[arrCategoryIndex objectAtIndex:nIndex] integerValue];
    selectedViewController.nCardIndex = (int)[[arrCardIndex objectAtIndex:nIndex] integerValue];
    
    [self.navigationController pushViewController:selectedViewController animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressEditButton:(id)sender {
    if (bEdit == 0){
        bEdit = 1;
        [self.btnEdit setBackgroundImage:[UIImage imageNamed:@"nav_Done.png"] forState:UIControlStateNormal];
        
        [self showAllOnButtons];
    }else{
        bEdit = 0;
        [self.btnEdit setBackgroundImage:[UIImage imageNamed:@"nav_Edit.png"] forState:UIControlStateNormal];
        
        [self hideAllOnButtons];
    }
}

#pragma mark Edit/Done Button Events
- (void) showAllOnButtons{
    for (int i=0; i<arrDate.count; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UITableViewCell *cell = [self.alertsTableView cellForRowAtIndexPath:indexPath];
        
        for (UIView *subView in cell.contentView.subviews){
            if ([subView isKindOfClass:[UIImageView class]]){
                UIImageView *imageView = (UIImageView *)subView;
                if (imageView.tag == 1)
                    imageView.hidden = YES;
            }
            
            if ([subView isKindOfClass:[UIButton class]]){
                UIButton *buttonOn = (UIButton *) subView;
                if (buttonOn.tag == 2000+i){
                    [buttonOn setFrame:CGRectMake(-20 , buttonOn.frame.origin.y, buttonOn.bounds.size.width, buttonOn.bounds.size.height)];
                    buttonOn.hidden = NO;
                    
                    CGRect viewFrame = buttonOn.frame;
                    viewFrame.origin.x = 5;
                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationBeginsFromCurrentState:YES];
                    [UIView setAnimationDuration:0.2f];
                    [buttonOn setFrame:viewFrame];
                    [UIView commitAnimations];
                }
            }
        }

        
    }
    
//    for (UIView *view in self.alertsTableView.subviews){
//        for (UITableViewCell *cell in view.subviews){
//            for (UIView *subView in cell.contentView.subviews){
//                if ([subView isKindOfClass:[UIImageView class]]){
//                    UIImageView *imageView = (UIImageView *)subView;
//                    if (imageView.tag == 1)
//                        imageView.hidden = YES;
//                }
//            }
//        }
//    }
}

- (void) hideAllOnButtons{
    for (int i=0; i<arrDate.count; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UITableViewCell *cell = [self.alertsTableView cellForRowAtIndexPath:indexPath];
        
        for (UIView *subView in cell.contentView.subviews){
            if ([subView isKindOfClass:[UIImageView class]]){
                UIImageView *imageView = (UIImageView *)subView;
                if (imageView.tag == 1)
                    imageView.hidden = NO;
            }
            
            if ([subView isKindOfClass:[UIButton class]]){
                UIButton *button = (UIButton *) subView;
                if (button.tag == 2000+i){
                    button.hidden = YES;
                }
                
                if (button.tag == 3000+i) {
                    button.hidden = YES;
                }
                
                if (button.tag == 4000+i) {
                    button.hidden = YES;
                }
            }
        }

    }
}

- (void) buttonOnClicked:(UIButton *)sender{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag-2000 inSection:0];
    
    UITableViewCell *cell = [self.alertsTableView cellForRowAtIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews){
        
        if ([subView isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton *) subView;
            if (button.tag == sender.tag)
                button.hidden = YES;
            
            if (button.tag == sender.tag+1000) {
                button.hidden = NO;
            }
            
            if (button.tag == sender.tag+2000) {
                button.hidden = NO;
                
                [button setFrame:CGRectMake(self.alertsTableView.bounds.size.width , button.frame.origin.y, button.bounds.size.width, button.bounds.size.height)];
                
                CGRect viewFrame = button.frame;
                viewFrame.origin.x -= 100;
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationDuration:0.2f];
                [button setFrame:viewFrame];
                [UIView commitAnimations];
            }
        }
    }
}

- (void) buttonOffClicked:(UIButton *)sender{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag-3000 inSection:0];
    
    UITableViewCell *cell = [self.alertsTableView cellForRowAtIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews){
        
        if ([subView isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton *) subView;
            if (button.tag == sender.tag)
                button.hidden = YES;
            
            if (button.tag == sender.tag-1000) {
                button.hidden = NO;
            }
            
            if (button.tag == sender.tag+1000) {
                button.hidden = YES;
            }

        }
    }
}

- (void) buttonDeleteClicked:(UIButton *)sender{
    int nIndex = (int)sender.tag - 4000;

    NSDate *sDate = (NSDate *)[arrDate objectAtIndex:nIndex];
    int sRepeat = (int)[[arrRepeat objectAtIndex:nIndex] integerValue];
    int sSound = (int)[[arrSound objectAtIndex:nIndex] integerValue];
    int sCategoryIndex = (int)[[arrCategoryIndex objectAtIndex:nIndex] integerValue];
    int sCardIndex = (int)[[arrCardIndex objectAtIndex:nIndex] integerValue];
    
    if([appDelegate searchAlertWithDate:sDate sRepeat:sRepeat sSound:sSound sCategoryIndex:sCategoryIndex sCardIndex:sCardIndex]){
        
        [appDelegate removeAlertWithDate:sDate sRepeat:sRepeat sSound:sSound sCategoryIndex:sCategoryIndex sCardIndex:sCardIndex];
    }
    
    [arrDate removeObjectAtIndex:nIndex];
    [arrRepeat removeObjectAtIndex:nIndex];
    [arrSound removeObjectAtIndex:nIndex];
    [arrCategoryIndex removeObjectAtIndex:nIndex];
    [arrCardIndex removeObjectAtIndex:nIndex];
    [self.alertsTableView reloadData];
}

@end
