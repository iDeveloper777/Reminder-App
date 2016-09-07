//
//  ImageProcessing.h
//  YAMOOD
//
//  Created by Ferenc Knebl on 4/2/15.
//  Copyright (c) 2015 Ferenc Knebl. All rights reserved.
//

#ifndef YAMOOD_ImageProcessing_h
#define YAMOOD_ImageProcessing_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ImageProcessing: NSObject
{
    UIDocumentInteractionController *dic;
}

-(UIImage *)captureScreenInRect:(CGRect)captureFrame currentView:(UIView *) currentView;
-(UIImage *) getImageFromCustomeSize:(UIImage *) fromImage customeRect:(CGRect) customeRect;

-(UIImage *) insertTextToImage:(UIImage *)currentImage text:(NSString *) text;
-(UIImage *) drawText:(NSString*) text inImage:(UIImage*) image atPoint:(CGPoint)   point;

- (void) saveImageToAlbum:(UIImage *)image;
@end
#endif
