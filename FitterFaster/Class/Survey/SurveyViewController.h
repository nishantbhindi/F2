//
//  SurveyViewController.h
//  FitterFaster
//
//  Created by WebInfoways on 13/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"

#import "SurveyCategory.h"
#import "SurveyQuesAns.h"

#import "SurveyQuesAnsCell.h"

@class AppDelegate;

@interface SurveyViewController : UIViewController 
{
    AppDelegate *appDelegate;
    SurveyCategory *objSurveyCategoryCurr;
    SurveyQuesAns *objSurveyQuesAnsCurr;
}
@property (nonatomic,retain) NSMutableArray *arrSurveyData;
@property (nonatomic) int intCurrCategory;
@property (nonatomic) int intCurrQuestion;

@property (nonatomic,retain) IBOutlet UILabel *lblCategory;
@property (nonatomic,retain) IBOutlet UILabel *lblQuestion;
@property (nonatomic,retain) IBOutlet UITableView *tblAnswers;
@property (nonatomic,retain) IBOutlet UIButton *btnNext;
@property (nonatomic,retain) IBOutlet UIButton *btnPrev;

-(void)setInitialParameter;
-(void)resetData;

-(IBAction)btnTappedSignUp:(id)sender;
-(IBAction)btnTappedBack:(id)sender;

@end
