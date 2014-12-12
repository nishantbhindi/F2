//
//  MainViewController.m
//  PhotoShare
//
//  Created by WebInfoways on 26/02/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MainViewController.h"

#define kFB_POSITION_Y          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 185.0 : 165.0) : ((g_IS_iOS7) ? 170.0 : 150.0))

@interface MainViewController () <CLLocationManagerDelegate>

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated{
}
- (void)viewWillDisappear:(BOOL)animated{
}
- (void)viewDidDisappear:(BOOL)animated{
}

#pragma mark - Set Initial Parameter
-(void)setInitialParameter{
    [self resetData];
}
#pragma mark Is iOS 7
-(BOOL)isiOS7
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7);
}

#pragma mark - Button Tapped Reset
-(IBAction)btnTappedReset:(id)sender{
}
-(void)resetData{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
/*
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        return YES;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        return YES;
    }
    return NO;
}*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}
- (void)dealloc {
    
    [super dealloc];
}

@end
