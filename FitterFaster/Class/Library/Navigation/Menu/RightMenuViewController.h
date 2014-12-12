//
//  RightMenuViewController.h
//  NavigationExample
//
//  Created by WebInfoways on 16/04/13.
//  Copyright (c) 2013 WebInfoways. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightMenuCell.h"
#import "RightMenuCellSelected.h"
#import "RightSubMenuCell.h"

@class AppDelegate;

/*
@class DashboardViewController;

@class PlaylistViewController;
@class MyPlaylistViewController;

@class AddAWorkViewController;
@class SellAWorkViewController;

//@class VideoViewController;
*/

@interface RightMenuViewController : UIViewController <UITableViewDataSource, UITabBarControllerDelegate> {
    AppDelegate *appDelegate;
    
    /*
    DashboardViewController *objDashboardViewController;
    
    PlaylistViewController *objPlaylistViewController;
    MyPlaylistViewController *objMyPlaylistViewController;
    
    AddAWorkViewController *objAddAWorkViewController;
    SellAWorkViewController *objSellAWorkViewController;
    
    //VideoViewController *objVideoViewController;
    */
    
    BOOL isProfileMenuShow;
    BOOL isMailMenuShow;
}
@property (strong, nonatomic) IBOutlet UIButton *btnProfile;
@property (strong, nonatomic) IBOutlet UIButton *btnMail;

@property (strong, nonatomic) IBOutlet UITableView *tblRightMenuList;

-(void)setInitialParameter;

-(IBAction)btnTappedProfile:(id)sender;
-(IBAction)btnTappedMail:(id)sender;

@end
