//
//  RandomViewController.m
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import "RandomViewController.h"
#import "AppDelegate.h"
#import "ImageProcessing.h"

#import "SetAlertViewController.h"

@interface RandomViewController (){
    AppDelegate *appDelegate;
    NSArray *imgCardsArray;
    NSMutableArray *arrCardImages;
    NSMutableArray *arrCardContents;
    
    int bPaid;
    int bNewDisplay;
    
    NSString *strContent;
}

@end

@implementation RandomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    arrCardImages = appDelegate.arrCardImages;
    arrCardContents = appDelegate.arrCardContents;
    
    bPaid = appDelegate.bPaid;
    
    bNewDisplay = 0;
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (appDelegate.foreground == 1 && appDelegate.arrReceivedDate.count > 0){
        NSArray *arrCards = [appDelegate.arrCardImages objectAtIndex:[[appDelegate.arrReceivedCategoryIndex objectAtIndex:appDelegate.arrReceivedCategoryIndex.count-1] integerValue]];
        NSString *imgName = [arrCards objectAtIndex:[[appDelegate.arrReceivedCardIndex objectAtIndex:appDelegate.arrReceivedCardIndex.count-1] integerValue]];
        
        self.img_Card.image = [UIImage imageNamed:imgName];
        appDelegate.showBadgeNumber = 0;
        
        int nIndex = (int)appDelegate.arrReceivedDate.count-1;
        
        [appDelegate removeReceivedAlertWithDate:(NSDate *)[appDelegate.arrReceivedDate objectAtIndex:nIndex]
                                         sRepeat:(int)[[appDelegate.arrReceivedRepeat objectAtIndex:nIndex] intValue]
                                          sSound:(int)[[appDelegate.arrReceivedSound objectAtIndex:nIndex] intValue]
                                  sCategoryIndex:(int)[[appDelegate.arrReceivedCategoryIndex objectAtIndex:nIndex] intValue]
                                      sCardIndex:(int)[[appDelegate.arrReceivedCardIndex objectAtIndex:nIndex] intValue]];
        
        appDelegate.foreground = 0;
        
        return;
    }
    
    if (bNewDisplay == 0){
        [self randomCardIndex];
        
        NSArray *tempContentsArray = [arrCardContents objectAtIndex:_nIndex];
        strContent = [NSString stringWithFormat:@"\"%@ \". Dr Rick Kausman's If not dieting Empowerment Cards App.", [tempContentsArray objectAtIndex:_nCardIndex]];
    }
    
    bNewDisplay = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Buttons Event
- (IBAction)press_Action_Button:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Please select" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Set Alert",@"Share This", @"Save to Library", nil];
    sheet.tag = 100;
    [sheet showInView:self.view];
    
}

#pragma mark ActionSheet
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 100) {
        if (buttonIndex == 0) { // Set Alert
            bNewDisplay = 1;
            SetAlertViewController *setAlerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SetAlertView"];
            
            setAlerViewController.nIndex = _nIndex;
            setAlerViewController.nCardIndex = _nCardIndex;
            
            [self.navigationController pushViewController:setAlerViewController animated:YES];
            
        }else if(buttonIndex == 1){ //Share This
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Please select" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email",@"Facebook", @"Twitter", nil];
            sheet.tag = 200;
            [sheet showInView:self.view];
            
        }else if(buttonIndex == 2){ //Save to Library
            [[ImageProcessing alloc] saveImageToAlbum:self.img_Card.image];
        }
    }
    
    if (actionSheet.tag == 200){
        if (buttonIndex == 0){ //Email
            [self showShareToEmail];
        }else if (buttonIndex == 1){ //Facebook
            [self showShareToFacebook];
        }else if (buttonIndex == 2){ // Twitter
            [self showShareToTwitter];
        }
    }
}

#pragma mark Sharing Methods
- (void)showShareToFacebook
{
    //Sharing photo!
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [fbSheetOBJ setInitialText:strContent];
        //[fbSheetOBJ addURL:[NSURL URLWithString:@"http://www.weblineindia.com"]];
        [fbSheetOBJ addImage:self.img_Card.image];
        
        [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
    }
}

- (void) showShareToTwitter
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheetOBJ setInitialText:strContent];
        //        [tweetSheetOBJ addURL:[NSURL URLWithString:@"http://www.weblineindia.com"]];
        [tweetSheetOBJ addImage:self.img_Card.image];
        
        [self presentViewController:tweetSheetOBJ animated:YES completion:Nil];
    }
}

- (void) showShareToEmail{
    NSString *emailTitle = @"Empowerment Card";
    NSString *messageBody = strContent;
    //    NSArray *toRecipents;
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    //    [mc setToRecipients:toRecipents];
    
    UIImage *myImage = self.img_Card.image;
    NSData *myImageData = UIImagePNGRepresentation(myImage);
    [mc addAttachmentData:myImageData mimeType:@"image/png" fileName:@"radio_app.png"];
    
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark randomCardIndex
- (void) randomCardIndex{
    _nIndex = arc4random() % 7;
    imgCardsArray = [arrCardImages objectAtIndex:_nIndex];
    if (bPaid == 0)
        _nCardIndex = 0;
    else
        _nCardIndex = arc4random() % imgCardsArray.count;
    
    self.img_Card.image = [UIImage imageNamed:[imgCardsArray objectAtIndex:_nCardIndex]];
}
@end
