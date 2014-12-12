//
//  LeftMenuViewController.h
//  NavigationExample
//
//  Created by WebInfoways on 16/04/13.
//  Copyright (c) 2013 WebInfoways. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@class HomeViewController;
//@class EditProfileViewController;
//@class SettingsViewController;

@class NewsletterViewController;

@class WebPageViewController;

/*
@class HelpViewController;
*/

@interface LeftMenuViewController : UIViewController {
    AppDelegate *appDelegate;
    
    HomeViewController *objHomeViewController;
    //EditProfileViewController *objEditProfileViewController;
    //SettingsViewController *objSettingsViewController;
    
    NewsletterViewController *objNewsletterViewController;
    
    WebPageViewController *objWebPageViewController;
    
    /*
    HelpViewController *objHelpViewController;
     */
}
@property(nonatomic,retain) IBOutlet UIImageView *imgPhoto;
@property(nonatomic,retain) IBOutlet UILabel *lblName;

@property(nonatomic,retain) IBOutlet UIScrollView *scrollViewMain;

-(void)setInitialParameter;
-(void)setUserData;
-(IBAction)btnTappedMenuLinks:(id)sender;

@end
