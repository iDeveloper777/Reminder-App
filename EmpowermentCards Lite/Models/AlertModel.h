//
//  BrandModel.h
//  Muse
//
//  Created by Ferenc Knebl on 23/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#ifndef EmpowermentCards_AlertModel_h
#define EmpowermentCards_AlertModel_h

#import <Foundation/Foundation.h>

@protocol AlertModel
@end


@interface AlertModel : NSObject

@property (strong, nonatomic) NSString *nDate;

@property (strong, nonatomic) NSString *nRepeat;
@property (strong, nonatomic) NSString *nSound;

@property (assign, nonatomic) int nCategoryIndex;
@property (assign, nonatomic) int nCardIndex;

- (instancetype) initAlertWithDate:(NSDate *)nDate
                           nRepeat:(NSString *)nRepeat
                            nSound:(NSString *)nSound
                    nCategoryIndex:(int) nCategoryIndex
                        nCardIndex:(int) nCardIndex;


@end

#endif
