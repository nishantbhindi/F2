//
//  SurveyQuesAns.m
//  FitterFaster
//
//  Created by WebInfoways on 20/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SurveyQuesAns.h"

@implementation SurveyQuesAns

@synthesize intQuestionID,strQuestion;
@synthesize arrAnswers;

-(void)dealloc{
    [self.strQuestion release];
    [self.arrAnswers release];
    
    [super dealloc];
}

@end
