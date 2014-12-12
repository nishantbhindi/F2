//
//  Newsletter.m
//  FitterFaster
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "Newsletter.h"

@implementation Newsletter

@synthesize intNewsletterID;
@synthesize strTitle,strSmallDesc,strLongDesc,strUrl;
@synthesize strDateTime;

-(void)dealloc{
    [self.strTitle release];
    [self.strSmallDesc release];
    [self.strLongDesc release];
    [self.strUrl release];
    [self.strDateTime release];
    
    [super dealloc];
}

@end
