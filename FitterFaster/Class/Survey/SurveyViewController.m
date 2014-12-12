//
//  SignUpViewController.m
//  FitterFaster
//
//  Created by WebInfoways on 13/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SurveyViewController.h"
#import "SurveyCategoryDBAdapter.h"

@interface SurveyViewController ()

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Initialize Page Data
-(void)setInitialParameter{
    [self resetData];
    
    self.arrSurveyData = [[NSMutableArray alloc] init];
    [self getSurveyData];
}

#pragma mark - Reset
-(void)resetData{
    self.intCurrCategory = 0;
    self.intCurrQuestion = 0;
}

#pragma mark - Get Survey Data
-(void)getSurveyData {
    if([self.arrSurveyData count]>0)
        [self.arrSurveyData removeAllObjects];
    
    SurveyCategoryDBAdapter *objSurveyCategoryDBAdapter = [[SurveyCategoryDBAdapter alloc] init];
    [objSurveyCategoryDBAdapter fetchSurveyData:self.arrSurveyData];
    [objSurveyCategoryDBAdapter release];
    
    /*
    //NSLog(@"%@", self.arrSurveyData);
    for(int i=0; i<self.arrSurveyData.count; i++)
    {
        SurveyCategory *objSurveyCategory = [self.arrSurveyData objectAtIndex:i];
        NSLog(@"----------------");
        NSLog(@"%d = %@", objSurveyCategory.intCategoryID, objSurveyCategory.strTitle);
        
        for(int j=0;j<objSurveyCategory.arrQuesAns.count;j++)
        {
            SurveyQuesAns *objSurveyQuesAns = [objSurveyCategory.arrQuesAns objectAtIndex:j];
            NSLog(@"%d = %@", objSurveyQuesAns.intQuestionID, objSurveyQuesAns.strQuestion);
            NSLog(@"Count = %lu", (unsigned long)objSurveyQuesAns.arrAnswers.count);
            NSLog(@"%@", objSurveyQuesAns.arrAnswers);
            NSLog(@"%@", [objSurveyQuesAns.arrAnswers objectAtIndex:0]);
        }
        NSLog(@"----------------");
    }
    */
    
    [self displaySurveyCategory];
}

#pragma mark - Display Survey Data
-(void)displaySurveyCategory{
    [self setNextPrevButton];
    
    objSurveyCategoryCurr = [self.arrSurveyData objectAtIndex:self.intCurrCategory];
    self.lblCategory.text = objSurveyCategoryCurr.strTitle;
    
    self.intCurrQuestion = 0;
    [self displaySurveyQuesAns];
}
-(void)displaySurveyQuesAns{
    objSurveyQuesAnsCurr = [objSurveyCategoryCurr.arrQuesAns objectAtIndex:self.intCurrQuestion];
    self.lblQuestion.text = objSurveyQuesAnsCurr.strQuestion;
    [_tblAnswers reloadData];
}
#pragma mark - UITableView Delegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return objSurveyQuesAnsCurr.arrAnswers.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SurveyQuesAnsCell";
    SurveyQuesAnsCell *cell = (SurveyQuesAnsCell *)[_tblAnswers dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)	{
        NSArray* nib;
        if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
            nib = [[NSBundle mainBundle] loadNibNamed:@"SurveyQuesAnsCell" owner:self options:nil];
        else
            nib = [[NSBundle mainBundle] loadNibNamed:@"SurveyQuesAnsCell_iPad" owner:self options:nil];
        
        for (id oneObject in nib) if ([oneObject isKindOfClass:[SurveyQuesAnsCell class]])
            cell = (SurveyQuesAnsCell *)oneObject;
        
        //cell = [nib objectAtIndex:0];
        cell.showsReorderControl = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];   //darkGrayColor
    }
    [cell.btnAnswer.layer setCornerRadius:3.0];
    [cell.btnAnswer.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.btnAnswer.layer setBorderWidth: 2.0];
    cell.btnAnswer.clipsToBounds = YES;
    
    //cell.btnAnswer.titleLabel.text = [objSurveyQuesAnsCurr.arrAnswers objectAtIndex:indexPath.row];
    NSDictionary *dicAns = [objSurveyQuesAnsCurr.arrAnswers objectAtIndex:indexPath.row];
    [cell.btnAnswer setTitle:[dicAns objectForKey:@"Answer"] forState:UIControlStateNormal];
    
    if([[dicAns objectForKey:@"IsSelected"] integerValue]==1){
        [cell.btnAnswer setBackgroundColor:[UIColor colorWithRed:64.0/255.0 green:197.0/255.0 blue:192.0/255.0 alpha:1.0]];
        [cell.btnAnswer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        [cell.btnAnswer setBackgroundColor:[UIColor clearColor]];
        [cell.btnAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [cell.btnAnswer setTag:indexPath.row];
    [cell.btnAnswer addTarget:self action:@selector(btnTappedAnswer:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)btnTappedAnswer:(id)sender{
    NSDictionary *dicAns = [objSurveyQuesAnsCurr.arrAnswers objectAtIndex:[sender tag]];
    
    if([[dicAns objectForKey:@"IsSelected"] integerValue]==1)
        [dicAns setValue:@"0" forKey:@"IsSelected"];
    else
        [dicAns setValue:@"1" forKey:@"IsSelected"];
    
    [_tblAnswers reloadData];
}

#pragma mark - Next/Prev Survey
-(void)setNextPrevButton{
    //Previous Button
    if(self.intCurrQuestion > 0)
        [self.btnPrev setHidden:FALSE];
    else if(self.intCurrCategory > 0)
        [self.btnPrev setHidden:FALSE];
    else
        [self.btnPrev setHidden:TRUE];
}
-(IBAction)btnTappedNextQues:(id)sender{
    if(self.intCurrQuestion < objSurveyCategoryCurr.arrQuesAns.count-1)
    {
        self.intCurrQuestion++;
        [self displaySurveyQuesAns];
    }
    else if(self.intCurrCategory < self.arrSurveyData.count-1)
    {
        self.intCurrCategory++;
        [self displaySurveyCategory];
    }
    else
        [self btnTappedSignUp:nil];
}
-(IBAction)btnTappedPrevQues:(id)sender{
    if(self.intCurrQuestion > 0)
    {
        self.intCurrQuestion--;
        [self displaySurveyQuesAns];
    }
    else if(self.intCurrCategory > 0)
    {
        self.intCurrCategory--;
        [self displaySurveyCategory];
    }
    else
        [self.btnPrev setHidden:TRUE];
}

#pragma mark - Btn Tapped SignUp
-(IBAction)btnTappedSignUp:(id)sender{
    SignUpViewController *objSignUpViewController;
    objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil] autorelease];
    
    /*
    if(g_IS_IPHONE_6PLUS_SCREEN)
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController6P" bundle:nil] autorelease];
    else if(g_IS_IPHONE_6_SCREEN)
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController6" bundle:nil] autorelease];
    else if(g_IS_IPHONE_5_SCREEN)
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil] autorelease];
    else if(g_IS_IPHONE_4_SCREEN)
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController4" bundle:nil] autorelease];
    //else if(g_IS_IPAD)
        //objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewControlleriPad" bundle:nil] autorelease];
    else
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController4" bundle:nil] autorelease];
    */
    
    //objSignUpViewController.imgPhotoPreview = imgPhotoToShare;
    [self.navigationController pushViewController:objSignUpViewController animated:YES];
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    [FunctionManager gotoBack:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    //[_lblTitle release];
    
    [super dealloc];
}

@end
