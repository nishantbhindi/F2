//
//  LeftMenuViewController.m
//  NavigationExample
//
//  Created by WebInfoways on 16/04/13.
//  Copyright (c) 2013 WebInfoways. All rights reserved.
//

#import "LeftMenuViewController.h"

#import "HomeViewController.h"
//#import "EditProfileViewController.h"
//#import "SettingsViewController.h"

#import "NewsletterViewController.h"

#import "WebPageViewController.h"

/*
#import "HelpViewController.h"
*/

//#define kSCROLL_DISPLAY_Y               ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 64.0 : 44.0) : ((g_IS_iOS7) ? 64.0 : 44.0))
//#define kSCROLL_HEIGHT_DISPLAY          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 504.0 : 504.0) : ((g_IS_iOS7) ? 416.0 : 416.0))
//#define kSCROLL_HEIGHT_DEFAULT          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 580.0 : 580.0) : ((g_IS_iOS7) ? 580.0 : 580.0))

#define kSCROLL_DISPLAY_Y               ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 135.0 : 115.0) : ((g_IS_iOS7) ? 135.0 : 115.0))
#define kSCROLL_HEIGHT_DISPLAY          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 433.0 : 433.0) : ((g_IS_iOS7) ? 345.0 : 345.0))
#define kSCROLL_HEIGHT_DEFAULT          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 475.0 : 475.0) : ((g_IS_iOS7) ? 475.0 : 475.0))

@interface LeftMenuViewController ()
@end

@implementation LeftMenuViewController

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
    [self setUserData];
}

#pragma mark - Set User Data
-(void)setUserData{
    //User Profile Image
    [_imgPhoto setImage:[UIImage imageNamed:@"img_no_image.png"]];
    /*
    if(appDelegate.objUser.imgPhoto==nil && (!appDelegate.objUser.strPhotoUrl || [appDelegate.objUser.strPhotoUrl isEmptyString]))
        [_imgPhoto setImage:[UIImage imageNamed:@"img_no_image.png"]];
    else{
        if(appDelegate.objUser.imgPhoto){
            [_imgPhoto setImage:appDelegate.objUser.imgPhoto];
        }
        else
        {
            if(!appDelegate.objUser.strPhotoUrl || [appDelegate.objUser.strPhotoUrl isEmptyString])
                [_imgPhoto setImage:[UIImage imageNamed:@"img_no_image.png"]];
            else
            {
                dispatch_queue_t imageQ = dispatch_queue_create("imageQ", NULL);
                dispatch_async(imageQ, ^{
                    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:appDelegate.objUser.strPhotoUrl]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(imageData){
                            appDelegate.objUser.imgPhoto = [UIImage imageWithData:imageData];
                            [_imgPhoto setImage:appDelegate.objUser.imgPhoto];
                        }
                    });
                });
                dispatch_release(imageQ);
            }
        }
    }
    */
    
    /*
    if(appDelegate.objUser.imgPhoto==nil)
        [_imgPhoto setImage:[UIImage imageNamed:@"img_no_image.png"]];
    else
        [_imgPhoto setImage:appDelegate.objUser.imgPhoto];
    */
    
    //_lblName.text = [NSString stringWithFormat:@"%@ %@", [appDelegate.objUser.strFirstName capitalizedString], [appDelegate.objUser.strLastName capitalizedString]];
    
    _lblName.text = [NSString stringWithFormat:@"%@ %@ !", [@"Rob" capitalizedString], [@"Ryan" capitalizedString]];
}

#pragma mark - Set Initial Parameter
-(void)setInitialParameter{
    [self.slidingViewController setAnchorRightRevealAmount:180.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    
    _scrollViewMain.scrollEnabled=YES;
    [_scrollViewMain setFrame:CGRectMake(0.0, kSCROLL_DISPLAY_Y, _scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DISPLAY)];
	[_scrollViewMain setContentSize:CGSizeMake(_scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DEFAULT)];
    [_scrollViewMain setContentOffset:CGPointMake(0.0, 0.0)];
	
	[self.view addSubview:_scrollViewMain];
    
    
    [_imgPhoto.layer setCornerRadius:10.0];
    [_imgPhoto.layer setBorderColor:[UIColor grayColor].CGColor];
    [_imgPhoto.layer setBorderWidth: 2.0];
    _imgPhoto.clipsToBounds = YES;
    
    /*
    //Initialize Objects//
    //objHelpViewController = [[[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil] autorelease];
    objHelpViewController = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
     */
    
    if(g_IS_IPHONE_5_SCREEN)
    {
        objHomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        //objEditProfileViewController = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:nil];
        //objSettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        
        objNewsletterViewController = [[NewsletterViewController alloc] initWithNibName:@"NewsletterViewController" bundle:nil];
        
        objWebPageViewController = [[WebPageViewController alloc] initWithNibName:@"WebPageViewController" bundle:nil];
        
    }
    else if(g_IS_IPHONE_4_SCREEN)
    {
        objHomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController4" bundle:nil];
        //objEditProfileViewController = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController4" bundle:nil];
        //objSettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController4" bundle:nil];
        
        objNewsletterViewController = [[NewsletterViewController alloc] initWithNibName:@"NewsletterViewController4" bundle:nil];
        
        objWebPageViewController = [[WebPageViewController alloc] initWithNibName:@"WebPageViewController4" bundle:nil];
    }
    else{
        objHomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPad" bundle:nil];
        //objEditProfileViewController = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController_iPad" bundle:nil];
        //objSettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
        
        objNewsletterViewController = [[NewsletterViewController alloc] initWithNibName:@"NewsletterViewController_iPad" bundle:nil];
        
        objWebPageViewController = [[WebPageViewController alloc] initWithNibName:@"WebPageViewController_iPad" bundle:nil];
    }
}

#pragma mark - Menu Tapped
-(IBAction)btnTappedMenuLinks:(id)sender
{
    if(([sender tag] == appDelegate.intSelectedMenuNo) && !([sender tag]==11 || [sender tag]==12 || [sender tag]==13))
        return;
    else
    {
        appDelegate.intSelectedMenuNo = [sender tag];
                
        UINavigationController *nc;
        switch ([sender tag]) {
            case 1:	//Home
            {
                nc = [[UINavigationController alloc] initWithRootViewController:objHomeViewController];
                //self.slidingViewController.topViewController = objHomeViewController;
            }
                break;
            case 2:	//Edit Profile
            {
                //nc = [[UINavigationController alloc] initWithRootViewController:objEditProfileViewController];
                //self.slidingViewController.topViewController = objEditProfileViewController;
            }
                break;
            case 3:	//Inspire
            {
                //nc = [[UINavigationController alloc] initWithRootViewController:objInspireViewController];
                //self.slidingViewController.topViewController = objInspireViewController;
            }
                break;
            case 4:	//Community
            {
                //nc = [[UINavigationController alloc] initWithRootViewController:objCommunityViewController];
                //self.slidingViewController.topViewController = objCommunityViewController;
            }
                break;
            case 5:	//Newsletter
            {
                nc = [[UINavigationController alloc] initWithRootViewController:objNewsletterViewController];
                //self.slidingViewController.topViewController = objNewsletterViewController;
            }
                break;
            case 6:	//Notification
            {
                //nc = [[UINavigationController alloc] initWithRootViewController:objNotificationsViewController];
                //self.slidingViewController.topViewController = objNotificationsViewController;
            }
                break;
            case 7:	//Settings
            {
                //nc = [[UINavigationController alloc] initWithRootViewController:objSettingsViewController];
                //self.slidingViewController.topViewController = objSettingsViewController;
            }
                break;
            case 8:	//SOS
            {
                //nc = [[UINavigationController alloc] initWithRootViewController:objSOSViewController];
                //self.slidingViewController.topViewController = objSOSViewController;
            }
                break;
            case 9:	//About
            {
                objWebPageViewController.strPageTitle = g_AboutAppTitle;
                objWebPageViewController.strPageUrl = g_AboutAppUrl;
                nc = [[UINavigationController alloc] initWithRootViewController:objWebPageViewController];
                //self.slidingViewController.topViewController = objWebPageViewController;
                
                /*
                objWebPageViewController.strPageTitle = g_HelpTitle;
                objWebPageViewController.strPageUrl = g_HelpUrl;
                
                objWebPageViewController.strPageTitle = g_PrivacyPolicyTitle;
                objWebPageViewController.strPageUrl = g_PrivacyPolicyUrl;
                
                objWebPageViewController.strPageTitle = g_TermsOfUseTitle;
                objWebPageViewController.strPageUrl = g_TermsOfUseUrl;
                
                objWebPageViewController.strPageTitle = g_FaqTitle;
                objWebPageViewController.strPageUrl = g_FaqUrl;
                
                objWebPageViewController.strPageTitle = g_AboutUsTitle;
                objWebPageViewController.strPageUrl = g_AboutUsUrl;
                */
            }
                break;
            case 10:	//Log Out
            {
                [FunctionManager gotoRoot:self];
                return;
            }
                break;                
            case 11:	//Support
            {
                [FunctionManager sendEmail:g_Subject mailBody:g_Body isBodyHTML:YES toRecipientList:[NSArray arrayWithObjects:g_ToEmail,nil] ccRecipientList:nil bccRecipientList:nil withImage:nil imageType:@"" viewController:self delegate:self];
                return;
            }
                break;
            case 12:	//Rate Us
            {
                [FunctionManager rateApplication:g_AppId];
                return;
            }
                break;
            case 13:	//Share
            {
                UIActivityViewController *controller = [[UIActivityViewController alloc]
                                                        initWithActivityItems:@[g_BodyShare, g_AppUrl]
                                                        applicationActivities:nil];
                [self presentViewController:controller animated:YES completion:nil];
                return;
            }
                break;
            case 14:	//Logout
            {
                //[FunctionManager gotoBack:self];
                [FunctionManager gotoRoot:self];
                return;
            }
                break;
            default:
            {
                nc = [[UINavigationController alloc] initWithRootViewController:objHomeViewController];
                //self.slidingViewController.topViewController = objHomeViewController;
            }
                break;
        }
        [nc setNavigationBarHidden:TRUE];
        self.slidingViewController.topViewController = nc;
        [nc release];
        
        //[slidingViewController.view addGestureRecognizer:slidingViewController.panGesture];
        //[self.navigationController pushViewController:slidingViewController animated:YES];
        
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }
    
    
    /*
    UINavigationController *navigationController;
    
    switch ([sender tag]) {
        case 1:	//Edit Profile
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objHelpViewController];
            self.slidingViewController.topViewController = objHelpViewController;
        }
            break;
        case 2:	//Settings
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objSettingViewController];
            self.slidingViewController.topViewController = objSettingViewController;
        }
            break;
        case 3:	//Notifications
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objNotificationViewController];
            self.slidingViewController.topViewController = objNotificationViewController;
        }
            break;
        case 4:	//Pending Request
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objBoardMailsViewController];
            self.slidingViewController.topViewController = objBoardMailsViewController;
        }
            break;
        case 5:	//My Buddy List
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objConnectionsViewController];
            self.slidingViewController.topViewController = objConnectionsViewController;
        }
            break;
        case 6:	//Blocked Buddy
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objOrganizationsViewController];
            self.slidingViewController.topViewController = objOrganizationsViewController;
        }
            break;
        case 7:	//About App
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objBoardNewsViewController];
            self.slidingViewController.topViewController = objBoardNewsViewController;
        }
            break;
        case 8:	//FAQ
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objBoardRoomsViewController];
            self.slidingViewController.topViewController = objBoardRoomsViewController;
        }
            break;
        case 9:	//About Us
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objBoardRoomsViewController];
            self.slidingViewController.topViewController = objBoardRoomsViewController;
        }
            break;
        case 10:	//Support
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objBoardRoomsViewController];
            self.slidingViewController.topViewController = objBoardRoomsViewController;
        }
            break;
        case 11:	//Rate Us
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objBoardRoomsViewController];
            self.slidingViewController.topViewController = objBoardRoomsViewController;
        }
            break;
            
        default:
        {
            navigationController = [[UINavigationController alloc] initWithRootViewController:objHelpViewController];
            self.slidingViewController.topViewController = objHelpViewController;
        }
            break;
    }
    
    [navigationController setNavigationBarHidden:YES];
    //slidingViewController.topViewController = navigationController; //objNotificationViewController
    
    //[slidingViewController.view addGestureRecognizer:slidingViewController.panGesture];
    //[self.navigationController pushViewController:slidingViewController animated:YES];
    
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
    */
    
    /*
    ////
    NSString *identifier = [NSString stringWithFormat:@"%@Top", [self.arrLeftMenuList objectAtIndex:indexPath.row]];
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
    ////
    */
}
#pragma mark Mail delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    //[controller dismissModalViewControllerAnimated:YES];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
