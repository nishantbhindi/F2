//
//  User.h
//
//
//  Created by WebInfoways on 09/05/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
	int intUserID;
	
	NSString *strFirstname;
    NSString *strLastname;
    NSString *strMobile;
    
    NSString *strUsername;  //Refers as Email Address
    NSString *strPassword;
    
    NSString *strBirthdate;
    
    NSString *strPhotoUrl;
    UIImage *imgPhoto;
    NSData *imgPhotoData;
    BOOL bolPhotoAvailable;
    
    NSString *strLoginWith;             //1=Social Media, 2 = Direct SignUp
    NSString *strSocialMediaType;       //1=Facebook, 2=Instagram, 3=Twitter	(LoginWith=1)
    NSString *strSocialMediaId;
}
@property(nonatomic) int intUserID;

@property(nonatomic, retain) NSString *strFirstname;
@property(nonatomic, retain) NSString *strLastname;
@property(nonatomic, retain) NSString *strMobile;

@property(nonatomic, retain) NSString *strUsername;
@property(nonatomic, retain) NSString *strPassword;

@property(nonatomic, retain) NSString *strBirthdate;

@property(nonatomic,retain) NSString *strPhotoUrl;
@property(nonatomic,retain) UIImage *imgPhoto;
@property(nonatomic,retain) NSData *imgPhotoData;
@property(nonatomic) BOOL bolPhotoAvailable;

@property(nonatomic, retain) NSString *strLoginWith;
@property(nonatomic, retain) NSString *strSocialMediaType;
@property(nonatomic, retain) NSString *strSocialMediaId;

@end
