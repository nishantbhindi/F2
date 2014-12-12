//
//  NewsletterCell.h
//  FitterFaster
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsletterCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UILabel *lblTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblSmallDesc;
@property (nonatomic,retain) IBOutlet UILabel *lblDate;

@property (nonatomic,retain) IBOutlet UIButton *btnCell;

@end
