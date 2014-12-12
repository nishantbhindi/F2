//
//  MainViewController.h
//  PhotoShare
//
//  Created by WebInfoways on 26/02/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface MainViewController : UIViewController {
    AppDelegate *appDelegate;
}

-(void)setInitialParameter;

-(IBAction)btnTappedReset:(id)sender;
-(void)resetData;

@end
