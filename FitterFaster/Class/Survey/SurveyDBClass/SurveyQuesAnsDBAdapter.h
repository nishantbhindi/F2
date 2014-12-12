//
//  SurveyQuesAnsDBAdapter.h
//  FitterFaster
//
//  Created by WebInfoways on 21/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SurveyQuesAns.h"

@interface SurveyQuesAnsDBAdapter : NSObject {
    //Appdelegate
    AppDelegate *appDelegate;
}

-(int)insertSurveyQuesAns:(SurveyQuesAns *)pobjSurveyQuesAns withCategoryID:(int)pintCategoryId;
-(BOOL)updateSurveyQuesAns:(SurveyQuesAns *)pobjSurveyQuesAns withCategoryID:(int)pintCategoryId;
-(BOOL)deleteSurveyQuesAnsById:(int)pintSurveyQuesAnsId;

-(void)selectSurveyQuesAnsById:(int)pintSurveyQuesAnsId :(NSMutableArray *)pArrSurveyQuesAns;
-(void)selectSurveyQuesAnsByCatId:(int)pintCategoryId :(NSMutableArray *)pArrSurveyQuesAns;

@end
