//
//  RightMenuCellSelected.h
//  VideoTest
//
//  Created by WebInfoways on 14/04/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightMenuCellSelected : UITableViewCell{
    UIImageView *imgMenu;
    UIButton *btnMenuImage;
    UILabel *lblTitle;
    UILabel *lblIsSelected;
    
	IBOutlet UIButton *btnMenu;
}
@property (nonatomic,retain) IBOutlet UIImageView *imgMenu;
@property (nonatomic,retain) IBOutlet UIButton *btnMenuImage;
@property (nonatomic,retain) IBOutlet UILabel *lblTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblIsSelected;
@property(nonatomic,retain)IBOutlet UIButton *btnMenu;

@end
