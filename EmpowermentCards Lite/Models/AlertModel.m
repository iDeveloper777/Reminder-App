//
//  AlertModel.m
//  Muse
//
//  Created by Ferenc Knebl on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#import "AlertModel.h"

@implementation AlertModel

- (instancetype) initAlertWithDate:(NSDate *)nDate
                           nRepeat:(NSString *)nRepeat
                            nSound:(NSString *)nSound
                    nCategoryIndex:(int) nCategoryIndex
                        nCardIndex:(int) nCardIndex{
    self = [super init];
    if (self){
        _nRepeat = nRepeat;
        _nSound = nSound;
        _nCategoryIndex = nCategoryIndex;
        _nCardIndex = nCardIndex;
    }
    
    return self;
}

@end
