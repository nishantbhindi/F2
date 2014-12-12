//
//  SignUpViewController.h
//  FitterFaster
//
//  Created by WebInfoways on 13/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSignUpViewController.h"
#import "HomeViewController.h"

@class AppDelegate;

@class LeftMenuViewController;
//@class RightMenuViewController;

@interface SignUpViewController : UIViewController <IGSessionDelegate, IGRequestDelegate>
{
    AppDelegate *appDelegate;
    
    ECSlidingViewController *slidingViewController;    
    LeftMenuViewController *objLeftMenuViewController;
    //RightMenuViewController *objRightMenuViewController;
    
    HomeViewController *objHomeViewController;
}
@property (nonatomic,retain) IBOutlet UILabel *lblInstagramUser;
@property (nonatomic,retain) IBOutlet UIButton *btnLoginWithInstagram;
@property (nonatomic,retain) IBOutlet UIButton *btnLogoutFromInstagram;

@property (nonatomic,retain) IBOutlet UILabel *lblFacebookUser;


-(IBAction)btnTappedLoginWithInstagram:(id)sender;
-(IBAction)btnTappedLogoutFromInstagram:(id)sender;

-(IBAction)btnTappedLoginWithTwitter:(id)sender;
-(void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier;

-(IBAction)btnTappedReset:(id)sender;
-(void)resetData;


-(void)setInitialParameter;
-(void)setMenu;
-(void)setControllers;

-(IBAction)btnTappedHome:(id)sender;
-(IBAction)btnTappedBack:(id)sender;

-(IBAction)btnTappedAppSignUp:(id)sender;

@end
