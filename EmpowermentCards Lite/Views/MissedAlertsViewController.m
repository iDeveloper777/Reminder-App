//
//  MissedAlertsViewController.m
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import "MissedAlertsViewController.h"
#import "AppDelegate.h"
#import "SelectedCardViewController.h"

@interface MissedAlertsViewController (){
    AppDelegate *appDelegate;
    
    NSMutableArray *arrCardImages;
    NSMutableArray *arrCardContents;
    
    NSMutableArray *arrReceivedDate;
    NSMutableArray *arrReceivedRepeat;
    NSMutableArray *arrReceivedSound;
    NSMutableArray *arrReceivedCategoryIndex;
    NSMutableArray *arrReceivedCardIndex;
}
@end

@implementation MissedAlertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.alertsTableView.hidden = NO;
    self.lblAlert.hidden = NO;
    
    [self getAllReceivedDatas];
    [self setLayout];
}

#pragma mark getAllDatas
- (void) getAllReceivedDatas{
    arrCardImages = appDelegate.arrCardImages;
    arrCardContents = appDelegate.arrCardContents;
    
    arrReceivedDate = [[NSMutableArray alloc] init];
    arrReceivedRepeat = [[NSMutableArray alloc] init];
    arrReceivedSound = [[NSMutableArray alloc] init];
    arrReceivedCategoryIndex = [[NSMutableArray alloc] init];
    arrReceivedCardIndex = [[NSMutableArray alloc] init];
    
    for (int i=0; i<appDelegate.arrReceivedDate.count; i++)
    {
        [arrReceivedDate addObject:(NSDate *)[appDelegate.arrReceivedDate objectAtIndex:i]];
        [arrReceivedRepeat addObject:(NSNumber *)[appDelegate.arrReceivedRepeat objectAtIndex:i]];
        [arrReceivedSound addObject:(NSNumber *)[appDelegate.arrReceivedSound objectAtIndex:i]];
        [arrReceivedCategoryIndex addObject:(NSNumber *)[appDelegate.arrReceivedCategoryIndex objectAtIndex:i]];
        [arrReceivedCardIndex addObject:(NSNumber *)[appDelegate.arrReceivedCardIndex objectAtIndex:i]];
    }
    
}

#pragma mark setLayout
- (void) setLayout{
    if (appDelegate.arrReceivedDate.count == 0) {
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
    return [arrReceivedDate count];
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
    NSArray *arrCards = [arrCardImages objectAtIndex:[[arrReceivedCategoryIndex objectAtIndex:indexPath.row] integerValue]];
    NSString *imgName = [arrCards objectAtIndex:[[arrReceivedCardIndex objectAtIndex:indexPath.row] integerValue]];
    
    UIImageView *imgCard = [[UIImageView alloc] initWithFrame:CGRectMake(10 , 10, 50, 75)];
    
    imgCard.image = [UIImage imageNamed:imgName];
    imgCard.tag = 1;
    [cell.contentView addSubview:imgCard];
    
    //CardContent
    NSArray *arrContents = [arrCardContents objectAtIndex:[[arrReceivedCategoryIndex objectAtIndex:indexPath.row] integerValue]];
    NSString *cardContent = [arrContents objectAtIndex:[[arrReceivedCardIndex objectAtIndex:indexPath.row] integerValue]];
    
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
    strRepeatDate = [appDelegate.repeatPickerData objectAtIndex:[[arrReceivedRepeat objectAtIndex:indexPath.row] integerValue]];
    
    NSDate *date = [arrReceivedDate objectAtIndex:indexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"E   dd:MM:yyyy   HH:mm"];
    strRepeatDate = [NSString stringWithFormat:@"%@ - %@", strRepeatDate, [formatter stringFromDate:date]];
    
    UILabel *lblRepeatDate = [[UILabel alloc] initWithFrame:CGRectMake(75, 60, nWidth-80, 20)];
    lblRepeatDate.text = strRepeatDate;
    lblRepeatDate.tag =3;
    [lblRepeatDate setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0]];
    [lblRepeatDate setTextColor:[UIColor grayColor]];
    [cell.contentView addSubview:lblRepeatDate];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelectedCardViewController *selectedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectedCardView"];
    
    selectedViewController.nIndex = (int)[[arrReceivedCategoryIndex objectAtIndex:indexPath.row] integerValue];
    selectedViewController.nCardIndex = (int)[[arrReceivedCardIndex objectAtIndex:indexPath.row] integerValue];
    
    [self.navigationController pushViewController:selectedViewController animated:YES];
    
    [self removeReceivedAlert:(int)indexPath.row];
}

#pragma mark tapGesture
- (void) tapGesture: (UIGestureRecognizer *) gestureRecognizer{
    UITextView *textView = (UITextView *)gestureRecognizer.view;
    int nIndex = (int)textView.tag - 1000;
    
    SelectedCardViewController *selectedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectedCardView"];
    
    selectedViewController.nIndex = (int)[[arrReceivedCategoryIndex objectAtIndex:nIndex] integerValue];
    selectedViewController.nCardIndex = (int)[[arrReceivedCardIndex objectAtIndex:nIndex] integerValue];
    
    [self.navigationController pushViewController:selectedViewController animated:YES];
    
    [self removeReceivedAlert:nIndex];
}

- (void) removeReceivedAlert:(int) nIndex{
    NSDate *sDate = (NSDate *)[arrReceivedDate objectAtIndex:nIndex];
    int sRepeat = (int)[[arrReceivedRepeat objectAtIndex:nIndex] integerValue];
    int sSound = (int)[[arrReceivedSound objectAtIndex:nIndex] integerValue];
    int sCategoryIndex = (int)[[arrReceivedCategoryIndex objectAtIndex:nIndex] integerValue];
    int sCardIndex = (int)[[arrReceivedCardIndex objectAtIndex:nIndex] integerValue];
    
    if([appDelegate searchReceivedAlertWithDate:sDate sRepeat:sRepeat sSound:sSound sCategoryIndex:sCategoryIndex sCardIndex:sCardIndex]){
        
        [appDelegate removeReceivedAlertWithDate:sDate sRepeat:sRepeat sSound:sSound sCategoryIndex:sCategoryIndex sCardIndex:sCardIndex];
    }
    
    [arrReceivedDate removeObjectAtIndex:nIndex];
    [arrReceivedRepeat removeObjectAtIndex:nIndex];
    [arrReceivedSound removeObjectAtIndex:nIndex];
    [arrReceivedCategoryIndex removeObjectAtIndex:nIndex];
    [arrReceivedCardIndex removeObjectAtIndex:nIndex];
    [self.alertsTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
