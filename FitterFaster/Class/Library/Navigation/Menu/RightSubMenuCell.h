//
//  RightSubMenuCell.h
//  VideoTest
//
//  Created by WebInfoways on 19/04/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightSubMenuCell : UITableViewCell{
    UILabel *lblTitle;
    UILabel *lblIsSelected;
    
	IBOutlet UIButton *btnMenu;
}
@property (nonatomic,retain) IBOutlet UILabel *lblTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblIsSelected;
@property(nonatomic,retain)IBOutlet UIButton *btnMenu;

@end
