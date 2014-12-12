//
//  HomeViewController.m
//  FitterFaster
//
//  Created by WebInfoways on 13/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SignUpViewController.h"
#import "STTwitter.h"

#define KAUTHURL        @"https://api.instagram.com/oauth/authorize/"
#define kAPIURl         @"https://api.instagram.com/v1/users/"
#define KCLIENTID       @"301d932147b14d14b229e3482fb0c162"
#define KCLIENTSERCRET  @"66e32480bcdd41abac45cbf081559f89"
#define kREDIRECTURI    @"http://www.fitterfaster.com/"

//#define kFB_POSITION_Y          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 185.0 : 165.0) : ((g_IS_iOS7) ? 170.0 : 150.0))
#define kFB_POSITION_Y          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 185.0 : 185.0) : ((g_IS_iOS7) ? 170.0 : 170.0))


@interface SignUpViewController () <FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@property (nonatomic, strong) STTwitterAPI *twitter;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated{
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(TwitterAuthCompleted:)
                                                 name:@"TWITTER_AUTH"
                                               object:self];*/
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TwitterAuthCompleted:)
                                                 name:@"TWITTER_AUTH" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
}
- (void)viewDidDisappear:(BOOL)animated{
    [FBSession.activeSession closeAndClearTokenInformation];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TWITTER_AUTH" object:nil];
}

#pragma mark - Initialize Page Data
-(void)setInitialParameter{
    [self resetData];
    
    //Facebook//
    [self addFBLoginButton];
    //Facebook End//
    
    //Instagram//
    [self checkForInstagram];
    //Instagram End//
    
    
    [self setMenu];
    [self setControllers];
}

#pragma mark - Button Tapped Reset
-(IBAction)btnTappedReset:(id)sender{
}
-(void)resetData{
    //Logout Facebook//
    //[FBSession.activeSession closeAndClearTokenInformation];
    
    _lblFacebookUser.text = @"Please login to Facebook";
    //Logout Facebook End//
    
    //Logout Instagram//
    [appDelegate.instagram logout];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_btnLoginWithInstagram setHidden:FALSE];
    [_btnLogoutFromInstagram setHidden:TRUE];
    _lblInstagramUser.text = @"Please login to Instagram";
    //Logout Instagram End//
}

#pragma mark - Add Facebook Button
-(void)addFBLoginButton{
    // Create Login View so that the app will be granted "status_update" permission.
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    //loginview.frame = CGRectOffset(loginview.frame, 5, 5);
    loginview.frame = CGRectOffset(loginview.frame, 51, kFB_POSITION_Y);    //51
    
    /*
#ifdef __IPHONE_7_0
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        //loginview.frame = CGRectOffset(loginview.frame, 49, 75);    //51
        loginview.frame = CGRectOffset(loginview.frame, 49, 410.0);    //51
    }
#endif
#endif
#endif
     */
    
    //NSLog(@"FB Size = %f, %f", loginview.frame.size.width, loginview.frame.size.height);
    loginview.delegate = self;
    [self.view addSubview:loginview];
    [loginview sizeToFit];
}
#pragma mark - Login with Facebook
/*
-(IBAction)btnTappedLoginWithFacebook:(id)sender{
    appDelegate.session = [[FBSession alloc] init];
 
    [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                    FBSessionState status,
                                                    NSError *error)
    {
        [appDelegate setSession:session];
 
        [self updateView];
    }];
}
- (void)updateView
{
    if (appDelegate.session.isOpen)
    {
        NSString *postUrl = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@&fields=email,first_name,last_name,name,location",
        appDelegate.session.accessTokenData.accessToken];
        NSLog(@"access_token=%@",postUrl);
 
        //{"email":"test.webinfoways\u0040gmail.com","first_name":"Web","last_name":"Infoways","name":"Web Infoways","id":"100005643540660"}
 
 
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",postUrl]]];
        [request setHTTPMethod:@"GET"];
        NSError *error;
        NSURLResponse *response;
        NSData *returnData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *returnString=[[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",returnString);
 
        //[self FB_User_login];
    }
}
*/

#pragma mark FBLoginViewDelegate
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    //LogIn
    
    // first get the buttons set for login mode
    // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    //NSLog(@"Hello %@!", user.first_name);
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.profilePic.profileID = user.objectID;
    self.loggedInUser = user;
    
    NSString *strFBImageUrl = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=small", user.objectID];
    
    NSString *strMsg = [NSString stringWithFormat:@"%@\n%@\n%@", user.objectID, user.name, strFBImageUrl];
    [FunctionManager showMessage:@"Facebook" withMessage:strMsg withDelegage:self];
    
    _lblFacebookUser.text = [NSString stringWithFormat:@"Welcome! '%@' to Facebook.", user.name];
    
    //Large size photo https://graph.facebook.com/{facebookId}/picture?type=large
    //Medium size photo https://graph.facebook.com/{facebookId}/picture?type=normal
    //Small size photo https://graph.facebook.com/{facebookId}/picture?type=small
    //Square photo https://graph.facebook.com/{facebookId}/picture?type=square
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    //LogOut
    
    _lblFacebookUser.text = @"Please login to Facebook";
    
    /*
     // test to see if we can use the share dialog built into the Facebook application
     FBLinkShareParams *p = [[FBLinkShareParams alloc] init];
     p.link = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
     BOOL canShareFB = [FBDialogs canPresentShareDialogWithParams:p];
     BOOL canShareiOS6 = [FBDialogs canPresentOSIntegratedShareDialogWithSession:nil];
     BOOL canShareFBPhoto = [FBDialogs canPresentShareDialogWithPhotos];
     
     self.buttonPostStatus.enabled = canShareFB || canShareiOS6;
     self.buttonPostPhoto.enabled = canShareFBPhoto;
     self.buttonPickFriends.enabled = NO;
     self.buttonPickPlace.enabled = NO;
     
     // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.
     [self.buttonPostStatus setTitle:@"Post Status Update (Logged Off)" forState:self.buttonPostStatus.state];
     
     self.profilePic.profileID = nil;
     self.labelFirstName.text = nil;
     self.loggedInUser = nil;
     */
}
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}

#pragma mark - Instagram Login
-(void)checkForInstagram
{
    //Logout
    /*[appDelegate.instagram logout];
     [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
     [[NSUserDefaults standardUserDefaults] synchronize];*/
    //Logout End
    
    appDelegate.instagram.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    appDelegate.instagram.sessionDelegate = self;
    
    /*
     if ([appDelegate.instagram isSessionValid]) {
        //IGListViewController* viewController = [[IGListViewController alloc] init];
        //[self.navigationController pushViewController:viewController animated:YES];
     
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"users/self", @"method", nil];
        [appDelegate.instagram requestWithParams:params delegate:self];
     } else {
        [appDelegate.instagram authorize:[NSArray arrayWithObjects:@"comments", @"likes", nil]];
     }
     */
}
-(IBAction)btnTappedLoginWithInstagram:(id)sender{
    //IGAppDelegate* appDelegate = (IGAppDelegate*)[UIApplication sharedApplication].delegate;
    //[appDelegate.instagram authorize:[NSArray arrayWithObjects:@"comments", @"likes", nil]];
    
    if ([appDelegate.instagram isSessionValid]) {
        //IGListViewController* viewController = [[IGListViewController alloc] init];
        //[self.navigationController pushViewController:viewController animated:YES];
        
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"users/self", @"method", nil];
        [appDelegate.instagram requestWithParams:params delegate:self];
    } else {
        [appDelegate.instagram authorize:[NSArray arrayWithObjects:@"comments", @"likes", nil]];
    }
}
-(IBAction)btnTappedLogoutFromInstagram:(id)sender{
    //IGAppDelegate* appDelegate = (IGAppDelegate*)[UIApplication sharedApplication].delegate;
    
    [appDelegate.instagram logout];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark IGSessionDelegate
-(void)igDidLogin {
    NSLog(@"Instagram did login");
    
    // here i can store accessToken
    [[NSUserDefaults standardUserDefaults] setObject:appDelegate.instagram.accessToken forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //IGListViewController* viewController = [[IGListViewController alloc] init];
    //[self.navigationController pushViewController:viewController animated:YES];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"users/self", @"method", nil];
    [appDelegate.instagram requestWithParams:params delegate:self];
}
-(void)igDidNotLogin:(BOOL)cancelled {
    NSLog(@"Instagram did not login");
    
    NSString* message = nil;
    if (cancelled) {
        message = @"Access cancelled!";
    } else {
        message = @"Access denied!";
    }
    
    [FunctionManager showMessage:@"" withMessage:message withDelegage:nil];
}

-(void)igDidLogout {
    NSLog(@"Instagram did logout");
    
    // remove the accessToken
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_btnLoginWithInstagram setHidden:FALSE];
    [_btnLogoutFromInstagram setHidden:TRUE];
    _lblInstagramUser.text = @"Please login to Instagram";
}
-(void)igSessionInvalidated {
    NSLog(@"Instagram session was invalidated");
}

#pragma mark IGRequestDelegate
- (void)request:(IGRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Instagram did fail: %@", error);
    [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
}
- (void)request:(IGRequest *)request didLoad:(id)result {
    NSLog(@"Instagram did load: %@", result);
    //NSArray *data = (NSArray*)[result objectForKey:@"data"];
    //NSArray *meta = (NSArray*)[result objectForKey:@"meta"];
    NSDictionary *data = (NSDictionary*)[result objectForKey:@"data"];
    
    //NSLog(@"Count: %d", [data count]);
    //NSLog(@"data: %@", data);
    //NSLog(@"meta: %@", meta);
    
    NSString *strId = (NSString*)[data objectForKey:@"id"];
    NSString *strFullName = (NSString*)[data objectForKey:@"full_name"];
    NSString *strUserName = (NSString*)[data objectForKey:@"username"];
    NSString *strProfilePic = (NSString*)[data objectForKey:@"profile_picture"];
    
    /*
     NSLog(@"Id: %@", strId);
     NSLog(@"Full Name: %@", strFullName);
     NSLog(@"User Name: %@", strUserName);
     NSLog(@"Profile Pic: %@", strProfilePic);
     */
    
    /*
     for(NSDictionary *item in data) {
        NSLog(@"Item: %@", item);
     }*/
    
    NSString *strMsg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", strId, strFullName, strUserName, strProfilePic];
    [FunctionManager showMessage:@"Instagram" withMessage:strMsg withDelegage:self];
    
    _lblInstagramUser.text = [NSString stringWithFormat:@"Welcome! '%@' to Instagram.", strFullName];
    
    [_btnLoginWithInstagram setHidden:TRUE];
    [_btnLogoutFromInstagram setHidden:FALSE];
}

#pragma mark - Login with Twitter
-(IBAction)btnTappedLoginWithTwitter:(id)sender{
    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:KCLIENT_KEY_TWITTER
                                                 consumerSecret:KCLIENT_SECRET_TWITTER];
    
    
    [_twitter postTokenRequest:^(NSURL *url, NSString *oauthToken) {
        NSLog(@"-- URL: %@", url);
        NSLog(@"-- oAuthToken: %@", oauthToken);
        [[UIApplication sharedApplication] openURL:url];
        
    } forceLogin:@(YES)
                    screenName:nil
                 oauthCallback:@"myapp://twitter_access_tokens/"
                    errorBlock:^(NSError *error) {
                        NSLog(@"-- Error: %@", error);
                    }];
}
#pragma mark Twitter delegate
-(void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier{
    [_twitter postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
        
        NSLog(@"-- screenName: %@  userID:  %@", screenName,userID);
        
        NSString *strMsg = [NSString stringWithFormat:@"%@\n%@", userID, screenName];
        [FunctionManager showMessage:@"Twitter" withMessage:strMsg withDelegage:self];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- Error: %@", [error localizedDescription]);
    }];
}
//- (void)TwitterAuthCompleted:(NSDictionary *)sourceDictionary{
- (void)TwitterAuthCompleted:(NSNotification *)notification{
    NSString *strToken = [[notification userInfo] valueForKey:@"token"];
    NSString *strVerifier = [[notification userInfo] valueForKey:@"verifier"];
    NSLog(@"%@ = %@", strToken,strVerifier);
    [self setOAuthToken:strToken oauthVerifier:strVerifier];
    
    //NSLog(@"%@", sourceDictionary);
    
    //NSDictionary *dicTwitter = (NSDictionary*)[sourceDictionary objectForKey:@"userInfo"];
    
    //NSString *strToken = (NSString *)[dicTwitter objectForKey:@"token"];
    //NSString *strVerifier = (NSString *)[dicTwitter objectForKey:@"verifier"];
    
    //[self setOAuthToken:strToken oauthVerifier:strVerifier];
}
/*
- (void)TwitterAuthCompleted:(NSNotification *)notification
{
    NSLog(@"%@",[notification object]); //You will get the Parameter
 
    NSString *strToken = [[notification userInfo] valueForKey:@"token"];
    NSString *strVerifier = [[notification userInfo] valueForKey:@"verifier"];
 
    [self setOAuthToken:strToken oauthVerifier:strVerifier];
}*/

#pragma mark - Set Menu
-(void)setMenu{
    //****//
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    //self.view.layer.shadowOpacity = 0.75f;
    //self.view.layer.shadowRadius = 10.0f;
    //self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    //****//
    
    slidingViewController = [[ECSlidingViewController alloc] init];
    //objLeftMenuViewController = [[[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController" bundle:nil] autorelease];
    //objRightMenuViewController = [[[RightMenuViewController alloc] initWithNibName:@"RightMenuViewController" bundle:nil] autorelease];
    
    if((g_IS_IPHONE_5_SCREEN))
        objLeftMenuViewController = [[[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController" bundle:nil] autorelease];
        //objRightMenuViewController = [[[RightMenuViewController alloc] initWithNibName:@"RightMenuViewController" bundle:nil] autorelease];
    else if((g_IS_IPHONE_4_SCREEN))
        objLeftMenuViewController = [[[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController4" bundle:nil] autorelease];
        //objRightMenuViewController = [[[RightMenuViewController alloc] initWithNibName:@"RightMenuViewController4" bundle:nil] autorelease];
    else
        objLeftMenuViewController = [[[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController_iPad" bundle:nil] autorelease];
        //objRightMenuViewController = [[[RightMenuViewController alloc] initWithNibName:@"RightMenuViewController_iPad" bundle:nil] autorelease];
    
    slidingViewController.underLeftViewController = objLeftMenuViewController;
    slidingViewController.underRightViewController = nil;
}
#pragma mark Set Controllers
-(void)setControllers{
    //objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
    objHomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    
    /*
    if(g_IS_IPHONE_6PLUS_SCREEN)
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController6P" bundle:nil] autorelease];
    else if(g_IS_IPHONE_6_SCREEN)
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController6" bundle:nil] autorelease];
    else if(g_IS_IPHONE_5_SCREEN)
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
    else if(g_IS_IPHONE_4_SCREEN)
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController4" bundle:nil] autorelease];
    //else if(g_IS_IPAD)
        //objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewControlleriPad" bundle:nil] autorelease];
    else
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController4" bundle:nil] autorelease];
    */
}

#pragma mark - User Action
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self btnTappedHome:nil];
    
    /*
    if(alertView.tag==1)
    {
        if(buttonIndex==0){     //Yes
            NSLog(@"Cancel");
            [self openWorkOutDoneScreen:0];
        }
        else{   //No
            [self btnTappedPlay:nil];
        }
    }*/
}

#pragma mark - Btn Tapped Home
-(IBAction)btnTappedHome:(id)sender{
    //appDelegate.intProfileSubMenuSelectedIndexNo = -1;
    //appDelegate.intMailSubMenuSelectedIndexNo = -1;
    //appDelegate.intMenuSelectedIndexNo = 0;

    appDelegate.intSelectedMenuNo = 1;
    
    slidingViewController.topViewController = objHomeViewController;
    [slidingViewController.view addGestureRecognizer:slidingViewController.panGesture];
    [self.navigationController pushViewController:slidingViewController animated:YES];
    
    
    /*
    HomeViewController *objHomeViewController;
    objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
    
    //
    if(g_IS_IPHONE_6PLUS_SCREEN)
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController6P" bundle:nil] autorelease];
    else if(g_IS_IPHONE_6_SCREEN)
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController6" bundle:nil] autorelease];
    else if(g_IS_IPHONE_5_SCREEN)
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
    else if(g_IS_IPHONE_4_SCREEN)
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController4" bundle:nil] autorelease];
    //else if(g_IS_IPAD)
        //objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewControlleriPad" bundle:nil] autorelease];
    else
        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController4" bundle:nil] autorelease];
    //
    
    //objHomeViewController.imgPhotoPreview = imgPhotoToShare;
    [self.navigationController pushViewController:objHomeViewController animated:YES];
     */
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    [FunctionManager gotoBack:self];
}

#pragma mark - Button Tapped App SignUp
-(IBAction)btnTappedAppSignUp:(id)sender{
    AppSignUpViewController *objAppSignUpViewController;
    objAppSignUpViewController = [[[AppSignUpViewController alloc] initWithNibName:@"AppSignUpViewController" bundle:nil] autorelease];
    
    /*
    if(g_IS_IPHONE_6PLUS_SCREEN)
        objAppSignUpViewController = [[[AppSignUpViewController alloc] initWithNibName:@"AppSignUpViewController6P" bundle:nil] autorelease];
    else if(g_IS_IPHONE_6_SCREEN)
        objAppSignUpViewController = [[[AppSignUpViewController alloc] initWithNibName:@"AppSignUpViewController6" bundle:nil] autorelease];
    else if(g_IS_IPHONE_5_SCREEN)
        objAppSignUpViewController = [[[AppSignUpViewController alloc] initWithNibName:@"AppSignUpViewController" bundle:nil] autorelease];
    else if(g_IS_IPHONE_4_SCREEN)
        objAppSignUpViewController = [[[AppSignUpViewController alloc] initWithNibName:@"AppSignUpViewController4" bundle:nil] autorelease];
    //else if(g_IS_IPAD)
        //objAppSignUpViewController = [[[AppSignUpViewController alloc] initWithNibName:@"AppSignUpViewControlleriPad" bundle:nil] autorelease];
    else
        objAppSignUpViewController = [[[AppSignUpViewController alloc] initWithNibName:@"AppSignUpViewController4" bundle:nil] autorelease];
    */
    
    //objAppSignUpViewController.imgPhotoPreview = imgPhotoToShare;
    [self.navigationController pushViewController:objAppSignUpViewController animated:YES];
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
    [_btnLoginWithInstagram release];
    [_btnLogoutFromInstagram release];
    
    [objHomeViewController release];
    
    [super dealloc];
}

@end
