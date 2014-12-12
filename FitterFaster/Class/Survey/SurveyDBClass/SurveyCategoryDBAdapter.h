//
//  SurveyCategoryDBAdapter.h
//  FitterFaster
//
//  Created by WebInfoways on 21/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SurveyCategory.h"
#import "SurveyQuesAns.h"

@interface SurveyCategoryDBAdapter : NSObject {
    //Appdelegate
    AppDelegate *appDelegate;
}

-(int)insertSurveyCategory:(SurveyCategory *)pobjSurveyCategory;
-(BOOL)updateSurveyCategory:(SurveyCategory *)pobjSurveyCategory;
-(BOOL)deleteSurveyCategoryById:(int)pintSurveyCategoryId;

-(void)selectSurveyCategoryById:(int)pintSurveyCategoryId :(NSMutableArray *)pArrSurveyCategory;

-(void)fetchSurveyData:(NSMutableArray *)pArrSurveyData;

@end
