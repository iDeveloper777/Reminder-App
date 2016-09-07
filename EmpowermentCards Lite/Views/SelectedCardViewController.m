//
//  SelectedCardViewController.m
//  EmpowermentCards
//
//  Created by Ferenc Knebl on 17/04/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import "SelectedCardViewController.h"
#import "AppDelegate.h"
#import "ImageProcessing.h"
#import "SetAlertViewController.h"

@interface SelectedCardViewController (){
    NSArray *imgCardsArray;
    NSMutableArray *imageViewArray;
    
    NSMutableArray *arrCardImages;
    NSMutableArray *arrCardContents;
    
    NSString *strContent;
    
    int bPaid;
}

@end

@implementation SelectedCardViewController
@synthesize imgCardName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    imgCardsArray = [appDelegate.arrCardImages objectAtIndex:_nIndex];
    arrCardImages = appDelegate.arrCardImages;
    arrCardContents = appDelegate.arrCardContents;
    
    NSArray *tempContentsArray = [arrCardContents objectAtIndex:_nIndex];
    strContent = [NSString stringWithFormat:@"\"%@ \". Dr Rick Kausman's If not dieting Empowerment Cards App.", [tempContentsArray objectAtIndex:_nCardIndex]];
    
    bPaid = appDelegate.bPaid;
    
    self.img_Card.image = [UIImage imageNamed:[imgCardsArray objectAtIndex:_nCardIndex]];
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
#pragma mark Buttons' Event
- (IBAction)press_Back_Button:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)press_Action_Button:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Please select" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Set Alert",@"Share This", @"Save to Library", nil];
    sheet.tag = 100;
    [sheet showInView:self.view];
}

#pragma mark ActionSheet
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 100) {
        if (buttonIndex == 0) { // Set Alert
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

@end
