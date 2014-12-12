//
//  AppSignUpViewController.h
//  FitterFaster
//
//  Created by WebInfoways on 03/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

#import "DatePickerVC.h"
#import "User.h"

@class AppDelegate;

@class LeftMenuViewController;
//@class RightMenuViewController;

@interface AppSignUpViewController : UIViewController <DatePickerViewChangeDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    AppDelegate *appDelegate;
    
    ECSlidingViewController *slidingViewController;
    LeftMenuViewController *objLeftMenuViewController;
    //RightMenuViewController *objRightMenuViewController;
    
    HomeViewController *objHomeViewController;
    
    
    float fltPageScl;
    int intCurrentInputID;
    
    int intRecordAddedId;
    
    int intSuccess;
    NSString *strMessage;
    
    BOOL bolPhotoAvailable;
}
@property(nonatomic) int intRecordAddedId;

@property(nonatomic) int intSuccess;
@property(nonatomic,retain) NSString *strMessage;

@property (nonatomic, retain) User *objUser;

@property(nonatomic,retain) IBOutlet UIView *viewInput;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollViewMain;

@property(nonatomic,retain) IBOutlet UIImageView *imgPhoto;
@property(nonatomic,retain) NSData *imgPhotoData;

@property(nonatomic,retain) IBOutlet UITextField *txtFirstName;
@property(nonatomic,retain) IBOutlet UITextField *txtEmail;
@property(nonatomic,retain) IBOutlet UITextField *txtPassword;
@property(nonatomic,retain) IBOutlet UITextField *txtConfirmPassword;
@property(nonatomic,retain) IBOutlet UIButton *btnBirthday;
@property(nonatomic,retain) NSString *strSelectedBirthDate;


-(void)setInitialParameter;
-(void)setMenu;
-(void)setControllers;
-(void)bindDefaultData;

-(void)addObserver;
-(void)removeAddedObserver;

-(IBAction)btnTappedPhoto:(id)sender;
-(IBAction)btnTappedBirthday:(UIButton*)sender;

-(IBAction)resetData:(id)sender;
-(void)resignOtherControl;
-(void)removeOptionPicker;
-(BOOL)checkEnteredData;
-(IBAction)btnTappedSignUp:(id)sender;
-(void)signUpUser;

-(IBAction)btnTappedDone:(id)sender;
-(IBAction)btnTappedNext:(id)sender;
-(IBAction)btnTappedPrev:(id)sender;

-(void)checkCurrentInputIDandPerformAction;

-(IBAction)btnTappedBack:(id)sender;

@end
