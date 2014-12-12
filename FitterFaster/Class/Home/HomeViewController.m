//
//  HomeViewController.m
//  FitterFaster
//
//  Created by WebInfoways on 13/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.slidingViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.slidingViewController.view removeGestureRecognizer:self.slidingViewController.panGesture];
}

#pragma mark - Click On Menu Items
-(IBAction)displayLeftMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Btn Tapped Logout
-(IBAction)btnTappedLogout:(id)sender
{
    [FunctionManager gotoRoot:self];
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
