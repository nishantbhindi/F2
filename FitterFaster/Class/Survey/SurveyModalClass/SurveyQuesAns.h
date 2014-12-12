//
//  SurveyQuesAns.h
//  FitterFaster
//
//  Created by WebInfoways on 20/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyQuesAns : NSObject {
    int intQuestionID;
    NSString *strQuestion;
    
    NSMutableArray *arrAnswers;
}
@property(nonatomic) int intQuestionID;
@property(nonatomic, retain) NSString *strQuestion;

@property(nonatomic, retain) NSMutableArray *arrAnswers;

@end
