//
//  NewsletterDetailViewController.m
//  FitterFaster
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "NewsletterDetailViewController.h"

@interface NewsletterDetailViewController ()

@end

@implementation NewsletterDetailViewController

@synthesize objNewsletter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated
{
}

#pragma mark - Initialize Page Data
-(void)setInitialParameter
{
    [self bindData];
}
-(void)bindData
{
    _lblTitle.text = objNewsletter.strTitle;
    _lblSmallDesc.text = objNewsletter.strSmallDesc;
    //_txtLongDesc.text = objNewsletter.strLongDesc;
    
    NSString *strDisplayDt = [FunctionManager getFormatedDate:objNewsletter.strDateTime withDateFormat:g_DateFormatDefault withDisplayFormat:g_DateFormatDisplay2];    //g_DateTimeFormatDefaultZone
    _lblDate.text = strDisplayDt;
    
    if([objNewsletter.strUrl isEmptyString])
        [_btnUrl setHidden:TRUE];
    else
        [_btnUrl setHidden:FALSE];
}

#pragma mark - Button Tapped URL
-(IBAction)btnTappedURL:(id)sender{
    [FunctionManager openUrlinSafari:self.objNewsletter.strUrl];
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
    [_lblTitle release];
    [_lblSmallDesc release];
    [_lblDate release];
    [_txtLongDesc release];
    [_btnUrl release];
    
    [super dealloc];
}

@end
