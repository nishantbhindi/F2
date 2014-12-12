//
//  AppSignUpViewController.m
//  FitterFaster
//
//  Created by WebInfoways on 03/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "AppSignUpViewController.h"

/*
 #define kSCROLL_DISPLAY_Y7              ((g_IS_IPHONE_5_SCREEN) ? 64.0 : 64.0)        //190.0 : 160.0
 #define kSCROLL_DISPLAY_Y               ((g_IS_IPHONE_5_SCREEN) ? 44.0 : 44.0)        //190.0 : 160.0
 #define kSCROLL_HEIGHT_DISPLAY          ((g_IS_IPHONE_5_SCREEN) ? 500.0 : 500.0)
 #define kSCROLL_HEIGHT_DEFAULT          ((g_IS_IPHONE_5_SCREEN) ? 500.0 : 500.0)
 //#define kSCROLL_HEIGHT_DEFAULT        311.0
 */

#define kOFFSET_FOR_KEYBOARD            256.0                                         //216.0
#define kSCROLL_DISPLAY_Y               ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 64.0 : 64.0) : ((g_IS_iOS7) ? 64.0 : 64.0))
#define kSCROLL_HEIGHT_DISPLAY          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 440.0 : 440.0) : ((g_IS_iOS7) ? 440.0 : 440.0))
#define kSCROLL_HEIGHT_DEFAULT          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 440.0 : 440.0) : ((g_IS_iOS7) ? 440.0 : 440.0))

#define kTag_Photo              1
#define kTag_FirstName          2
#define kTag_Email              3
#define kTag_Password           4
#define kTag_ConfirmPassword    5
#define kTag_Birthday           6

#define kPosition_Photo             ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)
#define kPosition_FirstName         ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)
#define kPosition_Email             ((g_IS_IPHONE_5_SCREEN) ? 15.0 : 15.0)
#define kPosition_Password          ((g_IS_IPHONE_5_SCREEN) ? 45.0 : 45.0)
#define kPosition_ConfirmPassword   ((g_IS_IPHONE_5_SCREEN) ? 75.0 : 75.0)
#define kPosition_Birthday          ((g_IS_IPHONE_5_SCREEN) ? 105.0 : 105.0)

#define kPosition_Bottom            ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)		//kSCROLL_HEIGHT_DEFAULT - kSCROLL_HEIGHT_DISPLAY

#define g_THUMB_IMAGE_WIDTH         75.0

#define kPlaceholder_BirthDate      @"Birth Date"

@interface AppSignUpViewController ()

@end

@implementation AppSignUpViewController

@synthesize intRecordAddedId;
@synthesize intSuccess, strMessage;
@synthesize objUser;
@synthesize strSelectedBirthDate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated{
    [self addObserver];
}
- (void)viewDidDisappear:(BOOL)animated{
    [self removeAddedObserver];
}

#pragma mark - Initial Parameter
-(void)setInitialParameter
{
    [self setMenu];
    [self setControllers];
    
    [self bindDefaultData];
    
    _txtFirstName.inputAccessoryView = _viewInput;
    _txtEmail.inputAccessoryView = _viewInput;
    _txtPassword.inputAccessoryView = _viewInput;
    _txtConfirmPassword.inputAccessoryView = _viewInput;
    
    
    _scrollViewMain.scrollEnabled=YES;
    [_scrollViewMain setFrame:CGRectMake(0.0, kSCROLL_DISPLAY_Y, _scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DISPLAY)];
    [_scrollViewMain setContentSize:CGSizeMake(_scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DEFAULT)];
    //[_scrollViewMain setContentOffset:CGPointMake(0.0, kPosition_Quantity)];
    [_scrollViewMain setContentOffset:CGPointMake(0.0, 0.0)];
    
    [self.view addSubview:_scrollViewMain];
    
    [self resetData:nil];
}
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
#pragma mark Bind Default Data
-(void)bindDefaultData
{    
}

#pragma mark - Observer
-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}
-(void)removeAddedObserver
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"applicationDidBecomeActive" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:self.view.window];
}
#pragma mark keyboard Show/Hide Methods
- (void)keyboardWillShow:(NSNotification *)notif
{
    [_scrollViewMain setFrame:CGRectMake(_scrollViewMain.frame.origin.x, _scrollViewMain.frame.origin.y, _scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DISPLAY-kOFFSET_FOR_KEYBOARD)];
    [_scrollViewMain setContentSize:CGSizeMake(_scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DEFAULT)];
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
}
- (void)keyboardWillHide:(NSNotification *)notif
{
    [_scrollViewMain setFrame:CGRectMake(_scrollViewMain.frame.origin.x, _scrollViewMain.frame.origin.y, _scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DISPLAY)];
    _scrollViewMain.contentSize=CGSizeMake(_scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DEFAULT);
    [_scrollViewMain setContentOffset:CGPointMake(0.0, kPosition_Photo)];
}

#pragma mark - Select Photo
-(IBAction)btnTappedPhoto:(id)sender
{
    [FunctionManager showActionSheet:@"Select Photo"  withCancelTitle:@"Cancel" withDestructiveTitle:@"" withOtherButtonTitles:@"Photo Library,Camera" withDelegage:self withViewController:self withTag:1];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //[self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:nil];
    } else if (buttonIndex == 1) {
        
        if ([FunctionManager isCameraDeviceAvailable]) {
            
            UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //[self presentModalViewController:picker animated:YES];
            [self presentViewController:picker animated:YES completion:nil];
        }
        else
            [FunctionManager showMessage:@"" withMessage:msgNoCameraAvailable withDelegage:nil];
        
    } else if (buttonIndex == 2) {
        //DLog(@"Cancel");
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    bolPhotoAvailable = TRUE;
    [self setPhotoImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)setPhotoImage:(UIImage *)pImg
{
    _imgPhotoData = [NSData dataWithData:UIImagePNGRepresentation(pImg)];
    //UIImage *imgThumb=[FunctionManager imageScaleAndCropWithFixWidth:pImg withWidth:g_THUMB_IMAGE_WIDTH];
    UIImage *imgThumb=[FunctionManager imageScaleAndCropWithFixWidth:pImg withWidth:_imgPhoto.frame.size.height];
    _imgPhoto.image=imgThumb;
}

#pragma mark - Select BirthDate
-(IBAction)btnTappedBirthday:(UIButton*)sender{
    intCurrentInputID = kTag_Birthday;
    
    if(_scrollViewMain.contentOffset.y>kPosition_Birthday)
        fltPageScl = _scrollViewMain.contentOffset.y;
    else
        fltPageScl = kPosition_Birthday;
    
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    
    
    DatePickerVC *objDatePickerVC;
    objDatePickerVC = [[DatePickerVC alloc] initWithNibNameAndData:self.strSelectedBirthDate withDateFormat:g_DateTimeFormatDefault withDateDisplayFormat:g_DateFormatDisplay2 withID:self withPickerOptionID:1 withButtonTag:[sender tag]];
    objDatePickerVC.delegate = self;
    [self.view addSubview:objDatePickerVC.view];
    objDatePickerVC.view.frame=CGRectMake(objDatePickerVC.view.frame.origin.x, self.view.frame.size.height-objDatePickerVC.view.frame.size.height, objDatePickerVC.view.frame.size.width, objDatePickerVC.view.frame.size.height);
    //[objPickerController release];
}
-(void)onSelect:(int)pintPickerOptionId withDate:(NSDate *)pdtSelectedDate
{
    if([self checkAgeVerification:pdtSelectedDate]){
        [self removeDatePicker];
        
        self.strSelectedBirthDate = [FunctionManager getFormatedDate:[pdtSelectedDate description] withDateFormat:g_DateTimeFormatDefaultZone withDisplayFormat:g_DateTimeFormatDefault];
        
        NSString *strBirthdateDisplayDt = [FunctionManager getFormatedDate:[pdtSelectedDate description] withDateFormat:g_DateTimeFormatDefaultZone withDisplayFormat:g_DateFormatDisplay2];
        [_btnBirthday setTitle:strBirthdateDisplayDt forState:UIControlStateNormal];
    }
}
#pragma mark Check BirthDate
-(BOOL)checkAgeVerification:(NSDate *)pdtSelectedDate
{
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:pdtSelectedDate
                                       toDate:today
                                       options:0];
    //return ageComponents.year;
    if(ageComponents.year>=18)
        return TRUE;
    else{
        [FunctionManager showMessage:nil withMessage:msgVerifyAge withDelegage:nil];
        return FALSE;
    }
    
    /*
     NSDate *today = [NSDate date];
     NSDate *yesterday = [today dateByAddingTimeInterval: -86400.0];
     
     //if([[NSDate date] compare:pdtSelectedDate] == NSOrderedDescending) // if current date is later in time than passed date
     if([yesterday compare:pdtSelectedDate] == NSOrderedDescending) // if current date is later in time than passed date
     {
     [FunctionManager showMessage:nil withMessage:msgCAAppointmentDateFuture withDelegage:nil];
     return FALSE;
     }
     return TRUE;
     */
}

#pragma mark - Button Tapped SignUp
#pragma mark Reset Data
-(IBAction)resetData:(id)sender
{
    intCurrentInputID = kTag_Photo;
    
    bolPhotoAvailable = FALSE;
    _imgPhotoData = nil;
    [_imgPhoto setImage:[UIImage imageNamed:@"img_no_image.png"]];
    
    _txtFirstName.text = @"";
    _txtEmail.text = @"";
    _txtPassword.text = @"";
    _txtConfirmPassword.text = @"";
    
    self.strSelectedBirthDate = @"";
    [_btnBirthday setTitle:kPlaceholder_BirthDate forState:UIControlStateNormal];
}
#pragma mark Resign Responder
-(void)resignOtherControl{
    [_txtFirstName resignFirstResponder];
    [_txtEmail resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtConfirmPassword resignFirstResponder];
    
    [self removeDatePicker];
    //[self removeOptionPicker];
}
-(void)removeOptionPicker{
    /*if([self.view.subviews containsObject:appDelegate.objPickerView])
     [appDelegate.objPickerView removeFromSuperview];*/
    
    /*
    for(int i=0;i<[self.view.subviews count];i++){
        //DLog(@"%@", [self.view.subviews objectAtIndex:i]);
     
        if ([[self.view.subviews objectAtIndex:i] isKindOfClass:[PickerView class]])
            [appDelegate.objPickerView removeFromSuperview];
    }*/
    
    /*
    for(int i=0;i<[self.view.subviews count];i++){
        //DLog(@"%@", [self.view.subviews objectAtIndex:i]);
        id nextResponder = [[self.view.subviews objectAtIndex:i] nextResponder];
        if ([nextResponder isKindOfClass:[PickerVC class]]) {
            [[self.view.subviews objectAtIndex:i] removeFromSuperview];
        }
    }*/
}
-(void)removeDatePicker{
    /*if([self.view.subviews containsObject:appDelegate.objPickerView])
     [appDelegate.objPickerView removeFromSuperview];*/
    
    /*
     for(int i=0;i<[self.view.subviews count];i++){
     //DLog(@"%@", [self.view.subviews objectAtIndex:i]);
     
     if ([[self.view.subviews objectAtIndex:i] isKindOfClass:[PickerView class]])
     [appDelegate.objPickerView removeFromSuperview];
     }*/
    for(int i=0;i<[self.view.subviews count];i++){
        //DLog(@"%@", [self.view.subviews objectAtIndex:i]);
        
        id nextResponder = [[self.view.subviews objectAtIndex:i] nextResponder];
        if ([nextResponder isKindOfClass:[DatePickerVC class]]) {
            [[self.view.subviews objectAtIndex:i] removeFromSuperview];
        }
    }
}

#pragma mark Check Entered Data
-(BOOL)checkEnteredData{
    if ([_txtFirstName.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterFirstName withDelegage:nil];
        return FALSE;
    }
    else if(![_txtEmail.text isEmptyString] && ![_txtEmail.text isValidEmail]){
        [FunctionManager showMessage:nil withMessage:msgEnterValidEmail withDelegage:nil];
        return FALSE;
    }
    else if ([_txtPassword.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterPassword withDelegage:nil];
        return FALSE;
    }
    else if ([_txtConfirmPassword.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterConfirmPassword withDelegage:nil];
        return FALSE;
    }
    else if (![_txtPassword.text isEqualToString:_txtConfirmPassword.text]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterPwdConfirmPwdMatch withDelegage:nil];
        return FALSE;
    }
    else if([self.strSelectedBirthDate isEmptyString]){
        [FunctionManager showMessage:nil withMessage:msgSelectBirthdate withDelegage:nil];
        return FALSE;
    }
    else {
    }
    return TRUE;
}
#pragma mark SignUp
-(IBAction)btnTappedSignUp:(id)sender
{
    if([self checkEnteredData]) {
        [self resignOtherControl];
        //[self signUpUser];
        
        [self openApp];
    }
}
#pragma mark Register User
-(void)signUpUser{
    /*
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"action"] = @"registration";
    
    parameters[@"first_name"] = _txtFirstName.text;
    parameters[@"email"] = _txtEmail.text;
    parameters[@"password"] = _txtPassword.text;
    
    NSData *imageData = UIImageJPEGRepresentation(_imgPhoto.image, 1.0);
    NSString *photoEncodedString = [imageData base64Encoding];
    parameters[@"user_avatar"] = photoEncodedString;
    
    NSString *strPostDOB = [FunctionManager getFormatedDate:self.strSelectedBirthDate withDateFormat:g_DateTimeFormatDefaultZone withDisplayFormat:g_DateFormatDefault];
    
    //parameters[@"birthdate"] = self.strSelectedBirthDate;
    parameters[@"birthdate"] = strPostDOB;
    
    if([appDelegate.strDeviceToken isEmptyString])
        parameters[@"device_id"] = @"";
    else
        parameters[@"device_id"] = appDelegate.strDeviceToken;    //appDelegate.strDeviceIdentifierForVendor
    parameters[@"mobile_type"] = @"0";        //0=iOS, 1=Android
    
    
    //iOS6 & Above = AFHTTPRequestOperationManager
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkSignUpResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
    }];
    
    */
}
-(void)checkSignUpResponse:(NSDictionary *)pdicResponse{
    /*
    int success = [[pdicResponse objectForKey:@"status"] intValue];
    
    if(success)
    {
//        NSDictionary *data = (NSDictionary*)[pdicResponse objectForKey:@"data"];
//        NSString *strId = (NSString*)[data objectForKey:@"CustomerId"];
//        NSLog(@"%@", strId);
        
        NSArray *data = (NSArray*)[pdicResponse objectForKey:@"data"];
        NSDictionary *dicData = (NSDictionary*)[data objectAtIndex:0];
        NSString *strId = (NSString*)[dicData objectForKey:@"CustomerId"];
        //NSLog(@"%@", strId);
        
        
//        if ([_btnTitle.titleLabel.text isEqualToString:g_Default_SelectText])
//            appDelegate.objUser.strTitle = @"";
//        else
//            appDelegate.objUser.strTitle = _btnTitle.titleLabel.text;

        
        appDelegate.objUser.intUserID = [strId intValue];
        appDelegate.objUser.strTitle = _btnTitle.titleLabel.text;
        appDelegate.objUser.strFirstname = _txtFirstName.text;
        appDelegate.objUser.strLastname = _txtLastName.text;
        appDelegate.objUser.strMobile = _txtMobile.text;
        
        appDelegate.objUser.strUsername = _txtUsername.text;
        appDelegate.objUser.strPassword = @"";
        
        appDelegate.objUser.strAddress = _txtAddress.text;
        appDelegate.objUser.strCity = _txtCity.text;
        appDelegate.objUser.strPostcode = _txtPostcode.text;
        
        appDelegate.objUser.strBirthdate = self.strSelectedBirthDate;
        
        //[FunctionManager addUserToNSUserDefaults:appDelegate.objUser forKey:@"User"];
        
        [self openApp];
    }
    else
        [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
     */
}
-(void)openApp{
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

#pragma mark - Control Delegate
#pragma mark TextField Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"%f", _scrollViewMain.contentOffset.y);
    /*
    if(textField==_txtContact)
    {
        NSCharacterSet *unacceptedInput = nil;
        unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        if([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1)
            return YES;
        else
            return NO;
    }
    else
        return YES;
    */
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //[self resignOtherControl];
    
    if(textField==_txtFirstName)
    {
        intCurrentInputID = kTag_FirstName;
        
        if(_scrollViewMain.contentOffset.y>kPosition_FirstName)
            fltPageScl = _scrollViewMain.contentOffset.y;
        else
            fltPageScl = kPosition_FirstName;
        
        //fltPageScl = 0.0;
        //fltPageScl = _scrollViewMain.contentOffset.y;
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    else if(textField==_txtEmail)
    {
        intCurrentInputID = kTag_Email;
        
        if(_scrollViewMain.contentOffset.y>kPosition_Email)
            fltPageScl = _scrollViewMain.contentOffset.y;
        else
            fltPageScl = kPosition_Email;
        
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    else if(textField==_txtPassword)
    {
        intCurrentInputID = kTag_Password;
        
        if(_scrollViewMain.contentOffset.y>kPosition_Password)
            fltPageScl = _scrollViewMain.contentOffset.y;
        else
            fltPageScl = kPosition_Password;
        
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    else if(textField==_txtConfirmPassword)
    {
        intCurrentInputID = kTag_ConfirmPassword;
        
        if(_scrollViewMain.contentOffset.y>kPosition_ConfirmPassword)
            fltPageScl = _scrollViewMain.contentOffset.y;
        else
            fltPageScl = kPosition_ConfirmPassword;
        
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    return YES;
}
#pragma mark - Keyboard Toolbox Button Tapped
-(IBAction)btnTappedDone:(id)sender
{
    [self resignOtherControl];
    fltPageScl = kPosition_Bottom;
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
}
-(IBAction)btnTappedClose:(id)sender
{
    //[self removeOptionPicker];
    [self removeDatePicker];
    
    fltPageScl = 0.0;
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
}
-(IBAction)btnTappedNext:(id)sender
{
    if(intCurrentInputID==kTag_Birthday)
    {
        [self resignOtherControl];
        fltPageScl = kPosition_Bottom;
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    else {
        intCurrentInputID = intCurrentInputID+1;
        [self checkCurrentInputIDandPerformAction];
    }
}
-(IBAction)btnTappedPrev:(id)sender
{
    if(intCurrentInputID==kTag_Photo)
    {
        [self resignOtherControl];
        fltPageScl = kPosition_Photo;
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    else {
        intCurrentInputID = intCurrentInputID-1;
        [self checkCurrentInputIDandPerformAction];
    }
}
#pragma mark - Check Current Input ID and Perform Action
-(void)checkCurrentInputIDandPerformAction
{
    [self resignOtherControl];
    
    UIButton *btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [btn setTag:intCurrentInputID];
    
    switch (intCurrentInputID) {
        case 1: //Photo
            fltPageScl = kPosition_Photo;
            [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
            [self btnTappedPhoto:nil];
            break;
        case 2: //First Name
            [_txtFirstName becomeFirstResponder];
            break;
        case 3: //Email
            [_txtEmail becomeFirstResponder];
            break;
        case 4: //Password
            [_txtPassword becomeFirstResponder];
            break;
        case 5: //Confirm Password
            [_txtConfirmPassword becomeFirstResponder];
            break;
        case 6: //Birthday
            [self btnTappedBirthday:btn];
            break;
    }
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    [FunctionManager gotoBack:self];
}

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
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

- (void)dealloc {
    [self.strMessage release];
    
    [self.strSelectedBirthDate release];
    
    [_imgPhoto release];
    //[_imgPhotoData release];
    
    [_txtFirstName release];
    [_txtEmail release];
    [_txtPassword release];
    [_txtConfirmPassword release];
    
    [_viewInput release];
    [_scrollViewMain release];
    
    [super dealloc];
}

@end
