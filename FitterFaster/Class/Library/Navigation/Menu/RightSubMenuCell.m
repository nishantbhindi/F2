//
//  RightSubMenuCell.m
//  VideoTest
//
//  Created by WebInfoways on 19/04/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "RightSubMenuCell.h"

@implementation RightSubMenuCell

@synthesize lblTitle,lblIsSelected,btnMenu;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [self.lblTitle release];
    [self.lblIsSelected release];
	[self.btnMenu release];
    
    [super dealloc];
}

@end
