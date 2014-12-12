//
//  NewsletterViewController.h
//  FitterFaster
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsletterDetailViewController.h"

#import "Newsletter.h"
#import "NewsletterCell.h"

@class AppDelegate;

@interface NewsletterViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property (nonatomic,retain) NSMutableArray *arrNewsletter;
@property (nonatomic,retain) IBOutlet UITableView *tblNewsletter;
@property (nonatomic,retain) IBOutlet UILabel *lblNoRecords;

-(void)setInitialParameter;
-(void)bindDefaultData;
-(void)resetData;

-(void)fetchNewsletter;

-(IBAction)btnTappedFeedback:(id)sender;

-(IBAction)displayLeftMenu:(id)sender;

@end
