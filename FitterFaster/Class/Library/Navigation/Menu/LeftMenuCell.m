//
//  LeftMenuCell.m
//  Board Prospects
//
//  Created by WebInfoways on 25/03/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "LeftMenuCell.h"

@implementation LeftMenuCell

@synthesize btnMenu;

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
	[self.btnMenu release];
    [super dealloc];
}

@end
