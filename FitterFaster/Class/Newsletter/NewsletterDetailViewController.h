//
//  NewsletterDetailViewController.h
//  FitterFaster
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Newsletter.h"

@class AppDelegate;

@interface NewsletterDetailViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property (nonatomic,retain) Newsletter *objNewsletter;

@property (nonatomic,retain) IBOutlet UILabel *lblTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblSmallDesc;
@property (nonatomic,retain) IBOutlet UILabel *lblDate;
@property (nonatomic,retain) IBOutlet UITextView *txtLongDesc;

@property (nonatomic,retain) IBOutlet UIButton *btnUrl;

-(void)setInitialParameter;
-(void)bindData;

-(IBAction)btnTappedURL:(id)sender;

-(IBAction)btnTappedBack:(id)sender;

@end
