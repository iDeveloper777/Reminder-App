//
//  SelectACardViewController.m
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import "SelectACardViewController.h"
#import "SelectedCardViewController.h"
#import "AppDelegate.h"

#import "SVProgressHUD.h"

@interface SelectACardViewController (){
    NSArray *imgCardsArray;
    NSMutableArray *imageViewArray;
    
    int scrollWidth;
    int scrollHeight;
    int scrollContentHeight;
    
    int bPaid;
}

@end

@implementation SelectACardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageViewArray = [[NSMutableArray alloc] init];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    imgCardsArray = [appDelegate.arrCardImages objectAtIndex:_nIndex];
    bPaid = appDelegate.bPaid;
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self performSelector:@selector(setLayoutCards) withObject:nil afterDelay:0.2];

}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.isSelectedTab2 == 1){
        [self.navigationController popToRootViewControllerAnimated:YES];
        appDelegate.isSelectedTab2 = 0;
        return;
    }
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
#pragma mark Disply Cards

- (void) setLayoutCards{
    scrollWidth = self.svCards.bounds.size.width;
    scrollHeight = self.svCards.bounds.size.height;
    scrollContentHeight = self.svCards.contentSize.height;
    
    int realHeight = 0;
    int paddingWidth = 2;
    int cellWidth = (scrollWidth - paddingWidth*4)/3;
    int cellHeight = (scrollHeight - paddingWidth*4)/3;
    int nRow = 0, nCol = 0;
    
    if (imgCardsArray.count % 3 == 0) {
        nRow = (int)(imgCardsArray.count / 3);
    }else{
        nRow = (int)(imgCardsArray.count / 3) + 1;
    }
    realHeight = paddingWidth * (nRow + 1) + cellHeight * nRow;
    [self.svCards setContentSize:CGSizeMake(scrollWidth, realHeight)];
    
    
    int nRealNum = 0;
    for (int i = 0; i < imgCardsArray.count; i++) {
        nRealNum = i + 1;
        
        nCol = nRealNum % 3;
        if (nCol == 0) nCol = 3;
        if (nRealNum % 3 == 1){
            nRow = (int)(nRealNum/3) + 1;
        }
        
        CGRect rect = CGRectMake(paddingWidth * nCol + cellWidth * (nCol-1), paddingWidth * nRow + cellHeight * (nRow - 1), cellWidth, cellHeight);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.image = [UIImage imageNamed:[imgCardsArray objectAtIndex:i]];
        [imageViewArray addObject:imageView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        singleTap.numberOfTapsRequired = 1;
        [imageView setUserInteractionEnabled:YES];
        [imageView addGestureRecognizer:singleTap];
        
        [self.svCards addSubview:imageView];
        
        UIImageView *mirrorImageView = [[UIImageView alloc] initWithFrame:rect];
        mirrorImageView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
        
        if (i == 0){
            mirrorImageView.alpha = 0.0;
        }else{
            if (bPaid == 0)
                mirrorImageView.alpha = 0.5;
            else
                mirrorImageView.alpha = 0.0;
        }
                
        [self.svCards addSubview:mirrorImageView];
        
    }
    
    [SVProgressHUD dismiss];
}

#pragma mark Images Tap Event
- (void) tapDetected:(UIGestureRecognizer *) gestureRecognizer{
    UIImageView *currentImageView = (UIImageView *)[gestureRecognizer view];
    
    int nCardIndex = 0;
    for (int i=0; i<imageViewArray.count; i++){
        if ([imageViewArray objectAtIndex:i] == currentImageView)
            nCardIndex = i;
    }
    
    if (bPaid == 0){
        if (nCardIndex != 0) return;
    }
    
    SelectedCardViewController *selectedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectedCardView"];
//    selectedViewController.imgCardName = [imgCardsArray objectAtIndex:nCardIndex];
    selectedViewController.nIndex = _nIndex;
    selectedViewController.nCardIndex = nCardIndex;
    
    [self.navigationController pushViewController:selectedViewController animated:YES];
}
#pragma mark Back Button
- (IBAction)press_Back_Button:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
