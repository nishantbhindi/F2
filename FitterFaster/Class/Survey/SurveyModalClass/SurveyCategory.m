//
//  SurveyCategory.m
//  FitterFaster
//
//  Created by WebInfoways on 20/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SurveyCategory.h"

@implementation SurveyCategory

@synthesize intCategoryID,strTitle;
@synthesize arrQuesAns;

-(void)dealloc{
    [self.strTitle release];
    [self.arrQuesAns release];
    
    [super dealloc];
}

@end
