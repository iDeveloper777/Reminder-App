//
//  BrandModel.m
//  Muse
//
//  Created by Ferenc Knebl on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#import "CardsModel.h"

@implementation CardsModel

- (instancetype) initCardsData{
    [self initCardsImages];
    [self initCardsContents];
    
    return self;
}

#pragma mark initCardsImages
- (void) initCardsImages{
    _arrCardImages01 = [NSArray arrayWithObjects:@"card00.jpg",@"card01.jpg",@"card02.jpg",@"card03.jpg",@"card04.jpg",@"card05.jpg",@"card06.jpg",@"card07.jpg",@"card08.jpg", nil];
    _arrCardImages02 = [NSArray arrayWithObjects:@"card09.jpg",@"card10.jpg",@"card11.jpg",@"card12.jpg",@"card13.jpg",@"card14.jpg",@"card15.jpg",@"card16.jpg", nil];
    _arrCardImages03 = [NSArray arrayWithObjects:@"card17.jpg",@"card18.jpg",@"card19.jpg",@"card20.jpg",@"card21.jpg",@"card22.jpg",@"card23.jpg",@"card24.jpg", nil];
    _arrCardImages04 = [NSArray arrayWithObjects:@"card25.jpg",@"card26.jpg",@"card27.jpg",@"card28.jpg",@"card29.jpg",@"card30.jpg",@"card31.jpg",@"card32.jpg",@"card33.jpg", nil];
    _arrCardImages05 = [NSArray arrayWithObjects:@"card34.jpg",@"card35.jpg",@"card36.jpg",@"card37.jpg",@"card38.jpg",@"card39.jpg", nil];
    _arrCardImages06 = [NSArray arrayWithObjects:@"card40.jpg",@"card41.jpg",@"card42.jpg",@"card43.jpg",@"card44.jpg",@"card45.jpg",@"card46.jpg",@"card47.jpg",@"card48.jpg",@"card49.jpg",@"card50.jpg",@"card51.jpg",@"card52.jpg", nil];
    _arrCardImages07 = [NSArray arrayWithObjects:@"card53.jpg",@"card54.jpg",@"card55.jpg",@"card56.jpg",@"card57.jpg",@"card58.jpg",@"card59.jpg",@"card60.jpg",@"card61.jpg",@"card62.jpg",@"card63.jpg",@"card64.jpg", nil];
    
    _arrCardImages = [[NSMutableArray alloc] init];
    [_arrCardImages addObject:_arrCardImages01];
    [_arrCardImages addObject:_arrCardImages02];
    [_arrCardImages addObject:_arrCardImages03];
    [_arrCardImages addObject:_arrCardImages04];
    [_arrCardImages addObject:_arrCardImages05];
    [_arrCardImages addObject:_arrCardImages06];
    [_arrCardImages addObject:_arrCardImages07];
}

#pragma mark initCardsContents
- (void) initCardsContents{
    _arrCardContents01 = [NSArray arrayWithObjects:@"I am pausing a few times during the course of a meal just to check out how I am going.",
                          @"Small changes can make a big difference",
                          @"I can eat whatever I like - all I have to do for this 'amazing' privilege is to first sit down and carefully think about what I really want.",
                          @"Progress is succeeding at small steps along the way.",
                          @"It is normal and natural to eat more on some days and less on other days.",
                          @"It's ok not to be perfect at this - I can take it a day at a time, a meal at a time.",
                          @"With awareness and understanding comes empowerment and choice.",
                          @"By looking after myself and my body in the best way I can, my weight will evolve to the healthiest level that is possible for me.",
                          @"Acheiving and maintaining a healthy comfortable weight is like putting together the pieces of a complex jigswa puzzle.", nil];
    _arrCardContents02 = [NSArray arrayWithObjects:@"I can have it if I want it, but do I really feel like it?",
                          @"It is normal and natural to do some non-hungry eating.",
                          @"I can have it if I want it, but will I really enjoy it?",
                          @"I can have it if I want it, but do I really feel like it NOW?",
                          @"I have faith in my body - it is an amazing self - regulator.",
                          @"Off focus times can be used as a learning opportunity.",
                          @"It can be scary to turst our intuition, but it is almost always dangerous not to trust it.",
                          @"The more I relax and enjoy my food, the easier it is to get in touch with my natural senses of hunger and fullness.", nil];
    _arrCardContents03 = [NSArray arrayWithObjects:@"If I am satisfied and not feeling like any more food, it is not a waste to put it away for another time.",
                          @"If we eat any old thing when hungry instead of what we desire, we end up eating any old thing AND what we desire.",
                          @"I am doing my best not to get too hungry. Hunger signals are a bit like our bladder signals. If we wait too long to respond, we are more likely to have an accident!",
                          @"It is important to accept that we all only have a finite amount of emotional energy.",
                          @"It is normal and natural to eat certain types of food some of the time, just for the taste of it.",
                          @"I am doing my best to remember that no single meal makes any significant differnce in the long term.",
                          @"I am using many of my senses to enjoy food. I am focusing an how the food looks, the smell, the taste and the texture.",
                          @"If we know we are eating for the taste of it, we often needless food to feel satisfied than we would if we were eating becuase we were physically hungry.", nil];
    _arrCardContents04 = [NSArray arrayWithObjects:@"I am doing my best to eat slowly and enjoy with all my senses.",
                          @"It's ok to enjoy food without feeling guilty.",
                          @"Eating more slowly helps me become more aware of my hunger and fullness levels.",
                          @"If we know it's ok to have it, it's much easier to eat more slowly, we usually enjoy our food more, and we end up eating less!",
                          @"All food is morally neutral.",
                          @"I am doing my best to think about food as 'everyday' food and 'sometimes' food.",
                          @"I am no longer a prisoner to food. I now take food and slowly have my evil way with it.",
                          @"Fast food only tastes good when eaten fast; if your taste buds dance slowly and sensually with it, you realise it can't dance.",
                          @"It's normal to eat less of the foods we enjoy the taste of now, because it's okay to have them again another time.", nil];
    _arrCardContents05 = [NSArray arrayWithObjects:@"A well worn path doesn't mean it's the right track.",
                          @"Weight loss diets don't work.",
                          @"I am doing my best to protect myself from the seduction of weight loss dieting.",
                          @"Going off focus is normal in the process of change.",
                          @"If we want to make long-term change, we can only continue to work on what we can change in a long-term way.",
                          @"The end depends on the beginning.", nil];
    _arrCardContents06 = [NSArray arrayWithObjects:@"I am doing my best to speak gently to myself.",
                          @"I am good enough just as I am.",
                          @"Lesser inner thigh doesn't neccessarily equate to more innner peace.",
                          @"I give myself the right to say 'no'.",
                          @"I am nurturing my true self.",
                          @"Weight doesn't equal worth.",
                          @"Today I am doing the best I can to look for things that are fun to do.",
                          @"I am no longer putting off my life until I reach some magic weight.",
                          @"I am being kinder to myself in terms of my body image.",
                          @"I am dressing for now.",
                          @"It's important to remember that changing our body doesn't necessarily lead to a better body image or a better self-esteem.",
                          @"What fashion tells us is best changes over time.",
                          @"We can lead happy, healthy, productive lives without being the current culture's idea of an ideal shape.", nil];
    _arrCardContents07 = [NSArray arrayWithObjects:@"Whatever physical activity I can do is worth while.",
                          @"I am looking for opportinuties to enjoy moving my body.",
                          @"Evidence shows that it is healthy behaviours, rather than the achievement of any particular weight, that determines optimal health.",
                          @"I am aiming to be healthy at my own natural weight.",
                          @"Being fit for living is a much more appropriate outcome of increasing physical activity than being fit to run a marathon.",
                          @"Physical activity is a vital in allowing us to achieve and maintain optimal health and quality of life.",
                          @"I am practising getting the balance between using what I know (my nutritional knowledge) and listening to how I feel (my intuition).",
                          @"Health and vitality come in all shapes and sizes.",
                          @"Very often, to get the balance right in the long term, we need to forget about the nutritional 'rules' for a while and just concentrate on working out what our body wants.",
                          @"There is no single magical goal weight that any particular person is meant to be, or stay at, all their adult life.",
                          @"Moving our body doesn't have to be a drag, a pain, an exercise that one must do to again 'good girl' points in life -  I am doing this for me!",
                          @"When I am ready, it's ok to fine tune what I am eating and drinking in a non-deprivational way.", nil];
    
    _arrCardContents = [[NSMutableArray alloc] init];
    [_arrCardContents addObject:_arrCardContents01];
    [_arrCardContents addObject:_arrCardContents02];
    [_arrCardContents addObject:_arrCardContents03];
    [_arrCardContents addObject:_arrCardContents04];
    [_arrCardContents addObject:_arrCardContents05];
    [_arrCardContents addObject:_arrCardContents06];
    [_arrCardContents addObject:_arrCardContents07];
}
@end
