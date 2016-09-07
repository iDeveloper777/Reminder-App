//
//  BrandModel.h
//  Muse
//
//  Created by Ferenc Knebl on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#ifndef EmpowermentCards_CardsModel_h
#define EmpowermentCards_CardsModel_h

#import <Foundation/Foundation.h>

@protocol CardsModel
@end


@interface CardsModel : NSObject

@property (strong, nonatomic) NSString* id;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* created;

@property (strong, nonatomic) NSMutableArray *arrCardImages;
@property (strong, nonatomic) NSArray *arrCardImages01;
@property (strong, nonatomic) NSArray *arrCardImages02;
@property (strong, nonatomic) NSArray *arrCardImages03;
@property (strong, nonatomic) NSArray *arrCardImages04;
@property (strong, nonatomic) NSArray *arrCardImages05;
@property (strong, nonatomic) NSArray *arrCardImages06;
@property (strong, nonatomic) NSArray *arrCardImages07;

@property (strong, nonatomic) NSMutableArray *arrCardContents;
@property (strong, nonatomic) NSArray *arrCardContents01;
@property (strong, nonatomic) NSArray *arrCardContents02;
@property (strong, nonatomic) NSArray *arrCardContents03;
@property (strong, nonatomic) NSArray *arrCardContents04;
@property (strong, nonatomic) NSArray *arrCardContents05;
@property (strong, nonatomic) NSArray *arrCardContents06;
@property (strong, nonatomic) NSArray *arrCardContents07;

- (instancetype) initCardsData;
@end

#endif
