//
//  NewsletterCell.m
//  FitterFaster
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "NewsletterCell.h"

@implementation NewsletterCell

@synthesize lblTitle,lblSmallDesc,lblDate;
@synthesize btnCell;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc {
    [self.lblTitle release];
    [self.lblSmallDesc release];
    [self.lblDate release];
    [self.btnCell release];
    
    [super dealloc];
}

@end
