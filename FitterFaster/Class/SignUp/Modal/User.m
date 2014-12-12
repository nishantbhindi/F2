//
//  User.m
//  
//
//  Created by WebInfoways on 09/05/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize intUserID;
@synthesize strFirstname,strLastname,strMobile;
@synthesize strUsername,strPassword;
@synthesize strBirthdate;
@synthesize strPhotoUrl,imgPhoto,imgPhotoData,bolPhotoAvailable;
@synthesize strLoginWith,strSocialMediaType,strSocialMediaId;

-(void)dealloc{
	[self.strFirstname release];
    [self.strLastname release];
    [self.strMobile release];
    
    [self.strUsername release];
    [self.strPassword release];
    
    [self.strBirthdate release];
    
    [self.strPhotoUrl release];
    [self.imgPhoto release];
    [self.imgPhotoData release];
    
    [self.strLoginWith release];
    [self.strSocialMediaType release];
    [self.strSocialMediaId release];
    
	[super dealloc];
}

@end
