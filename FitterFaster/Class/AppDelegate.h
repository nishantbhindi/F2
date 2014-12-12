//
//  AppDelegate.h
//  FitterFaster
//
//  Created by WebInfoways on 03/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworkActivityIndicatorManager.h"

#import "ClsInternetChecking.h"
//#import "LocationManager.h"
#import "DBAdapter.h"

// Global Function
#import "FunctionManager.h"
#import "DBFunctionManager.h"

@class MainViewController;
@class LandingViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;
@property (strong, nonatomic) MainViewController *viewController;
@property (strong, nonatomic) LandingViewController *landingViewController;

// Internet Checking
@property (nonatomic,retain) ClsInternetChecking *objInternetAvailable;
@property (nonatomic,retain) IBOutlet UIView *viewNoInternet;

// Database
@property (nonatomic, retain) DBAdapter *objDBAdapter;

// GPS Location
/*
@property (nonatomic, retain) LocationManager *objLocationManager;
@property (nonatomic,retain) IBOutlet UIView *viewAllowGPSLocation;
@property (nonatomic,retain) IBOutlet UILabel *lblAllowGPSMessage;
@property (nonatomic) BOOL isGPSLocationActive;
// Default GPS Data
@property (nonatomic) BOOL intGPSEnable;
@property (nonatomic, retain) NSString *strCurrentAddress;
@property (nonatomic, assign) double douCurrentLatitude;
@property (nonatomic, assign) double douCurrentLongitude;
*/

// Show/Hide Loading
@property (nonatomic,retain) IBOutlet UIView *viewLoading;
@property (nonatomic,retain) IBOutlet UILabel *lblLoadingMessage;

@property (nonatomic) NSInteger intSelectedMenuNo;

@property (strong, nonatomic) FBSession *session;
@property (strong, nonatomic) Instagram *instagram;

-(void)initializeAppData;
-(void)checkDeviceCompatibility;

-(void)checkForStoredData;
-(void)checkForSettingsData;

// Show/Hide Internet Connection View
-(void)showNoInterntConnection;
-(void)removeNoInternetView;

// GPS Location
/*
-(void)showAllowGPSLocationView;
-(IBAction)closeApp:(id)sender;
-(void)closeAppForceFully;
*/

@end

