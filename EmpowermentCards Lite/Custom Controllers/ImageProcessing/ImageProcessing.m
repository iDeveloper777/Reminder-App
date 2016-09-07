//
//  ImageProcessing.m
//  YAMOOD
//
//  Created by Ferenc Knebl on 4/2/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageProcessing.h"

@implementation ImageProcessing

#pragma mark - Object Lifecycle

//capture screen and return UIImage
-(UIImage *)captureScreenInRect:(CGRect)captureFrame currentView:(UIView *)currentView{
    
    CALayer *layer;
    layer = currentView.layer;
    UIGraphicsBeginImageContext(CGSizeMake(captureFrame.size.width, captureFrame.size.height));
    CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}

//get Image From Large Image by custom size
-(UIImage *) getImageFromCustomeSize:(UIImage *) fromImage customeRect:(CGRect) customeRect
{
    if (customeRect.origin.x<0) {
        customeRect.origin.x = 0;
    }
    if (customeRect.origin.y<0) {
        customeRect.origin.y = 0;
    }
    
    CGFloat cgWidth = CGImageGetWidth(fromImage.CGImage);
    CGFloat cgHeight = CGImageGetHeight(fromImage.CGImage);
    if (CGRectGetMaxX(customeRect)>cgWidth) {
        customeRect.size.width = cgWidth-customeRect.origin.x;
    }
    if (CGRectGetMaxY(customeRect)>cgHeight) {
        customeRect.size.height = customeRect.origin.y;
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(fromImage.CGImage, customeRect);
    UIImage *resultImage=[UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    resultImage = [UIImage imageWithCGImage:resultImage.CGImage scale:fromImage.scale orientation:fromImage.imageOrientation];
    return resultImage;
    
}

- (UIImage *) insertTextToImage:(UIImage *)currentImage text:(NSString *) text
{
    UIImage *img = [self drawText:text inImage:currentImage atPoint:CGPointMake(currentImage.size.width, currentImage.size.height)];
    return img;
}

-(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    //UIFont *font = [UIFont fontWithName:@"Helvetica Light" size:180];
    float ratio = 8;
    int imgHeight = image.size.height;
    int imgWidth = image.size.width;
    
    UIFont *font = [UIFont boldSystemFontOfSize: imgWidth/8];
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, imgWidth, imgHeight)];
    
    float textX = (float)point.x/2 - (float)[text length] /2 * ((float) imgWidth/8/2);
    float textY = (float)point.y/ratio*6.5;
    
    CGRect rect = CGRectMake(textX, textY, imgWidth, imgHeight);
    [[UIColor blackColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void) saveImageToAlbum:(UIImage *)image
{
    UIImage *img = image;
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Your image saved successfully. Please check your album." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
@end

