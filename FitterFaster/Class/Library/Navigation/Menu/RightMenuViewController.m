//
//  RightMenuViewController.m
//  NavigationExample
//
//  Created by WebInfoways on 16/04/13.
//  Copyright (c) 2013 WebInfoways. All rights reserved.
//

#import "RightMenuViewController.h"

/*
#import "DashboardViewController.h"

#import "PlaylistViewController.h"
#import "MyPlaylistViewController.h"

#import "AddAWorkViewController.h"
#import "SellAWorkViewController.h"

//#import "VideoViewController.h"
*/

@interface RightMenuViewController ()
@property (nonatomic, strong) NSArray *arrRightMenuList;
@property (nonatomic, strong) NSArray *arrProfileMenuList;
@property (nonatomic, strong) NSArray *arrMailMenuList;
@property (nonatomic, assign) CGFloat peekLeftAmount;
@end

@implementation RightMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
        self.peekLeftAmount = 165.0f;    //40.0f;
    else
        self.peekLeftAmount = 528.0f;    //40.0f;
    
    [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
    self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated{
    [_tblRightMenuList reloadData];
}

#pragma mark - Set Initial Parameter
-(void)setInitialParameter{
    if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
        [self.slidingViewController setAnchorRightRevealAmount:155.0f]; //280.0f
    else
        [self.slidingViewController setAnchorRightRevealAmount:240.0f]; //280.0f
    
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    self.arrRightMenuList = [NSArray arrayWithObjects:@"Dashboard", @"Playlist", @"Inventory", @"Add a Work", @"LFP Vault", @"Sell a Work", @"Trace", @"Affiliates", @"ArtRent", @"Exhibitions", @"Fair Art Trade", @"Documents", @"Backups", @"Audit Reporting", nil];
    
    self.arrProfileMenuList = [NSArray arrayWithObjects:@"Profile", @"Membership Plans", @"Edit Password", @"Logout", nil];
    self.arrMailMenuList = [NSArray arrayWithObjects:@"Inbox", @"Sent Item", nil];
    
    _tblRightMenuList.backgroundColor = [UIColor clearColor];    //darkGrayColor
	_tblRightMenuList.separatorStyle = UITableViewCellSeparatorStyleNone;
	[_tblRightMenuList flashScrollIndicators];
	_tblRightMenuList.bounces = NO;


    //Initialize Controller Objects//
    /*
    if((g_IS_IPHONE_5_SCREEN)){
        //objDashboardViewController = [[[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil] autorelease];
        objDashboardViewController = [[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil];
        
        objPlaylistViewController = [[PlaylistViewController alloc] initWithNibName:@"PlaylistViewController" bundle:nil];
        objMyPlaylistViewController = [[MyPlaylistViewController alloc] initWithNibName:@"MyPlaylistViewController" bundle:nil];
        
        objAddAWorkViewController = [[AddAWorkViewController alloc] initWithNibName:@"AddAWorkViewController" bundle:nil];
        objSellAWorkViewController = [[SellAWorkViewController alloc] initWithNibName:@"SellAWorkViewController" bundle:nil];
        
        //objVideoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
    }
    else if((g_IS_IPHONE_4_SCREEN)){
        //objDashboardViewController = [[[DashboardViewController alloc] initWithNibName:@"DashboardViewController4" bundle:nil] autorelease];
        objDashboardViewController = [[DashboardViewController alloc] initWithNibName:@"DashboardViewController4" bundle:nil];
        
        objPlaylistViewController = [[PlaylistViewController alloc] initWithNibName:@"PlaylistViewController4" bundle:nil];
        objMyPlaylistViewController = [[MyPlaylistViewController alloc] initWithNibName:@"MyPlaylistViewController4" bundle:nil];
        
        objAddAWorkViewController = [[AddAWorkViewController alloc] initWithNibName:@"AddAWorkViewController4" bundle:nil];
        objSellAWorkViewController = [[SellAWorkViewController alloc] initWithNibName:@"SellAWorkViewController4" bundle:nil];
        
        //objVideoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController4" bundle:nil];
    }
    else{
        //objDashboardViewController = [[[DashboardViewController alloc] initWithNibName:@"DashboardViewController_iPad" bundle:nil] autorelease];
        objDashboardViewController = [[DashboardViewController alloc] initWithNibName:@"DashboardViewController_iPad" bundle:nil];
        
        //objPlaylistViewController = [[PlaylistViewController alloc] initWithNibName:@"PlaylistViewController_iPad" bundle:nil];
        objMyPlaylistViewController = [[MyPlaylistViewController alloc] initWithNibName:@"MyPlaylistViewController_iPad" bundle:nil];
        
        objAddAWorkViewController = [[AddAWorkViewController alloc] initWithNibName:@"AddAWorkViewController_iPad" bundle:nil];
        objSellAWorkViewController = [[SellAWorkViewController alloc] initWithNibName:@"SellAWorkViewController_iPad" bundle:nil];
        
        //objVideoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController_iPad" bundle:nil];
    }
    //Initialize Controller Objects End//
    
    appDelegate.intProfileSubMenuSelectedIndexNo = -1;
    appDelegate.intMailSubMenuSelectedIndexNo = -1;
     */
}

#pragma mark - Sub-Menu Add
-(IBAction)btnTappedProfile:(id)sender{
    [_btnMail setBackgroundColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0]];
    [_btnMail setFrame:CGRectMake(_btnMail.frame.origin.x, _btnMail.frame.origin.y, _btnMail.frame.size.width, 44.0)];
    isMailMenuShow = FALSE;
    
    if(isProfileMenuShow){
        isProfileMenuShow = FALSE;
        [_btnProfile setBackgroundColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0]];
        [_btnProfile setFrame:CGRectMake(_btnProfile.frame.origin.x, _btnProfile.frame.origin.y, _btnProfile.frame.size.width, 44.0)];
    }
    else{
        isProfileMenuShow = TRUE;
        //[_btnProfile setBackgroundColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]];
        [_btnProfile setBackgroundColor:[UIColor darkGrayColor]];
        [_btnProfile setFrame:CGRectMake(_btnProfile.frame.origin.x, _btnProfile.frame.origin.y, _btnProfile.frame.size.width, 49.0)];
    }
    
    [_tblRightMenuList reloadData];
}
-(IBAction)btnTappedMail:(id)sender{
    [_btnProfile setBackgroundColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0]];
    [_btnProfile setFrame:CGRectMake(_btnProfile.frame.origin.x, _btnProfile.frame.origin.y, _btnProfile.frame.size.width, 44.0)];
    isProfileMenuShow = FALSE;
    
    if(isMailMenuShow){
        isMailMenuShow = FALSE;
        [_btnMail setBackgroundColor:[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0]];
        [_btnMail setFrame:CGRectMake(_btnMail.frame.origin.x, _btnMail.frame.origin.y, _btnMail.frame.size.width, 44.0)];
    }
    else{
        isMailMenuShow = TRUE;
        //[_btnMail setBackgroundColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]];
        [_btnMail setBackgroundColor:[UIColor darkGrayColor]];
        [_btnMail setFrame:CGRectMake(_btnMail.frame.origin.x, _btnMail.frame.origin.y, _btnMail.frame.size.width, 49.0)];
    }
    
    [_tblRightMenuList reloadData];
}

#pragma mark - TableView delegate method
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isProfileMenuShow && !isMailMenuShow)
        return self.arrRightMenuList.count + self.arrProfileMenuList.count;
    else if(isMailMenuShow && !isProfileMenuShow)
        return self.arrRightMenuList.count + self.arrMailMenuList.count;
    else
        return self.arrRightMenuList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(isProfileMenuShow && !isMailMenuShow && (indexPath.row<[self.arrProfileMenuList count]))
    {
        if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
            return 25.0;
        else
            return 35.0;
    }
    else if(isMailMenuShow && !isProfileMenuShow && (indexPath.row<[self.arrMailMenuList count]))
    {
        if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
            return 25.0;
        else
            return 35.0;
    }
    else
    {
        /*
        int intCurrentRow = 0;
        
        if(isProfileMenuShow && !isMailMenuShow)
            intCurrentRow = indexPath.row-[self.arrProfileMenuList count];
        else if(isMailMenuShow && !isProfileMenuShow)
            intCurrentRow = indexPath.row-[self.arrMailMenuList count];
        else
            intCurrentRow = indexPath.row;
        
        //if((indexPath.row == appDelegate.intMenuSelectedIndexNo) && (appDelegate.intMenuSelectedIndexNo==0 || appDelegate.intMenuSelectedIndexNo==1))
        if(intCurrentRow == appDelegate.intMenuSelectedIndexNo)
        {
            if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
                return 105.0;
            else
                return 125.0;
        }
        else
        {
            if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
                return 35.0;
            else
                return 50.0;;
        }
        */
        
        return 35.0;
    }
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
    
    /*
    if(isProfileMenuShow && !isMailMenuShow && (indexPath.row<[self.arrProfileMenuList count]))
    {
        static NSString *CellIdentifier = @"RightSubMenuCell";
        RightSubMenuCell *cell = (RightSubMenuCell *)[_tblRightMenuList dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)	{
            NSArray* nib;
            //nib = [[NSBundle mainBundle] loadNibNamed:@"RightSubMenuCell" owner:self options:nil];
            
            if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
                nib = [[NSBundle mainBundle] loadNibNamed:@"RightSubMenuCell" owner:self options:nil];
            else
                nib = [[NSBundle mainBundle] loadNibNamed:@"RightSubMenuCell_iPad" owner:self options:nil];
            
            for (id oneObject in nib) if ([oneObject isKindOfClass:[RightSubMenuCell class]])
                cell = (RightSubMenuCell *)oneObject;
            
            //cell = [nib objectAtIndex:0];
            cell.showsReorderControl = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];   //darkGrayColor
        }
        if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN)){
            cell.lblTitle.font=[UIFont fontWithName:@"Montserrat-Bold" size:12.0];
        }
        else{
            cell.lblTitle.font=[UIFont fontWithName:@"Montserrat-Bold" size:14.0];
        }
        
        cell.lblTitle.text = [self.arrProfileMenuList objectAtIndex:indexPath.row];
        if(indexPath.row == appDelegate.intProfileSubMenuSelectedIndexNo){
            [cell.lblIsSelected setBackgroundColor:[UIColor colorWithRed:26.0/255.0 green:161.0/255.0 blue:225.0/255.0 alpha:1.0]];
            [cell.btnMenu setEnabled:FALSE];
        }
        else{
            [cell.lblIsSelected setBackgroundColor:[UIColor clearColor]];
            [cell.btnMenu setEnabled:TRUE];
        }
        
        [cell.btnMenu setTag:indexPath.row];
        [cell.btnMenu addTarget:self action:@selector(btnTappedMenuLinks:) forControlEvents:UIControlEventTouchDown];
        
        return cell;
    }
    else if(isMailMenuShow && !isProfileMenuShow && (indexPath.row<[self.arrMailMenuList count]))
    {
        static NSString *CellIdentifier = @"RightSubMenuCell";
        RightSubMenuCell *cell = (RightSubMenuCell *)[_tblRightMenuList dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)	{
            NSArray* nib;
            //nib = [[NSBundle mainBundle] loadNibNamed:@"RightSubMenuCell" owner:self options:nil];
            
            if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
                nib = [[NSBundle mainBundle] loadNibNamed:@"RightSubMenuCell" owner:self options:nil];
            else
                nib = [[NSBundle mainBundle] loadNibNamed:@"RightSubMenuCell_iPad" owner:self options:nil];
            
            for (id oneObject in nib) if ([oneObject isKindOfClass:[RightSubMenuCell class]])
                cell = (RightSubMenuCell *)oneObject;
            
            //cell = [nib objectAtIndex:0];
            cell.showsReorderControl = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];   //darkGrayColor
        }
        if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN)){
            cell.lblTitle.font=[UIFont fontWithName:@"Montserrat-Bold" size:12.0];
        }
        else{
            cell.lblTitle.font=[UIFont fontWithName:@"Montserrat-Bold" size:14.0];
        }
        
        cell.lblTitle.text = [self.arrMailMenuList objectAtIndex:indexPath.row];
        if(indexPath.row == appDelegate.intMailSubMenuSelectedIndexNo){
            [cell.lblIsSelected setBackgroundColor:[UIColor colorWithRed:26.0/255.0 green:161.0/255.0 blue:225.0/255.0 alpha:1.0]];
            [cell.btnMenu setEnabled:FALSE];
        }
        else{
            [cell.lblIsSelected setBackgroundColor:[UIColor clearColor]];
            [cell.btnMenu setEnabled:TRUE];
        }
        
        [cell.btnMenu setTag:indexPath.row];
        [cell.btnMenu addTarget:self action:@selector(btnTappedMenuLinks:) forControlEvents:UIControlEventTouchDown];
        
        return cell;
    }
    else
    {
        int intCurrentRow = 0;
        
        if(isProfileMenuShow && !isMailMenuShow)
            intCurrentRow = indexPath.row-[self.arrProfileMenuList count];
        else if(isMailMenuShow && !isProfileMenuShow)
            intCurrentRow = indexPath.row-[self.arrMailMenuList count];
        else
            intCurrentRow = indexPath.row;
        
        
        //if((indexPath.row == appDelegate.intMenuSelectedIndexNo) && (appDelegate.intMenuSelectedIndexNo==0 || appDelegate.intMenuSelectedIndexNo==1))
        if(intCurrentRow == appDelegate.intMenuSelectedIndexNo)
        {
            static NSString *CellIdentifier = @"RightMenuCellSelected";
            RightMenuCellSelected *cell = (RightMenuCellSelected *)[_tblRightMenuList dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)	{
                NSArray* nib;
                //nib = [[NSBundle mainBundle] loadNibNamed:@"RightMenuCell" owner:self options:nil];
                
                if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
                    nib = [[NSBundle mainBundle] loadNibNamed:@"RightMenuCellSelected" owner:self options:nil];
                else
                    nib = [[NSBundle mainBundle] loadNibNamed:@"RightMenuCellSelected_iPad" owner:self options:nil];
                
                for (id oneObject in nib) if ([oneObject isKindOfClass:[RightMenuCellSelected class]])
                    cell = (RightMenuCellSelected *)oneObject;
                
                //cell = [nib objectAtIndex:0];
                cell.showsReorderControl = NO;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=[UIColor clearColor];   //darkGrayColor
            }
            if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN)){
                cell.lblTitle.font=[UIFont fontWithName:@"Montserrat-Bold" size:13.0];
            }
            else{
                cell.lblTitle.font=[UIFont fontWithName:@"Montserrat-Bold" size:16.0];
            }
            cell.lblTitle.text = [self.arrRightMenuList objectAtIndex:intCurrentRow];
            
            switch (appDelegate.intMenuSelectedIndexNo) {
                case 0:	//Dashboard
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_deshboard_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_deshboard_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 1:	//Playlist
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_playlist_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_playlist_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 2:	//Inventory
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_inventory_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_inventory_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 3:	//Add a Work
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_addawork_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_addawork_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 4:	//LFP Vault
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_lfpvault_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_lfpvault_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 5:	//Sell a Work
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_sellawork_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_sellawork_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 6:	//Trace
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_trace_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_trace_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 7:	//Affiliates
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_affiliates_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_affiliates_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 8:	//ArtRent
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_artwork_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_artwork_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 9:	//Exhibitions
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_exhibitions_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_exhibitions_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 10:    //Fair Art Trade
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_fairarttrade_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_fairarttrade_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 11:	//Documents
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_documents_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_documents_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 12:	//Backups
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_backup_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_backup_selected.png"] forState:UIControlStateNormal];
                }
                    break;
                case 13:	//Audit Reporting
                {
                    [cell.imgMenu setImage:[UIImage imageNamed:@"ico_menu_auditreporting_selected.png"]];
                    [cell.btnMenuImage setImage:[UIImage imageNamed:@"ico_menu_auditreporting_selected.png"] forState:UIControlStateNormal];
                }
                    break;
            }
            
            if(intCurrentRow == appDelegate.intMenuSelectedIndexNo){
                [cell.lblIsSelected setBackgroundColor:[UIColor colorWithRed:26.0/255.0 green:161.0/255.0 blue:225.0/255.0 alpha:1.0]];
                [cell.btnMenu setEnabled:FALSE];
            }
            else{
                [cell.lblIsSelected setBackgroundColor:[UIColor clearColor]];
                [cell.btnMenu setEnabled:TRUE];
            }
            
            [cell.btnMenu setTag:indexPath.row];
            [cell.btnMenu addTarget:self action:@selector(btnTappedMenuLinks:) forControlEvents:UIControlEventTouchDown];
            
            return cell;
        }
        else
        {
            static NSString *CellIdentifier = @"RightMenuCell";
            RightMenuCell *cell = (RightMenuCell *)[_tblRightMenuList dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)	{
                NSArray* nib;
                //nib = [[NSBundle mainBundle] loadNibNamed:@"RightMenuCell" owner:self options:nil];
                
                if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
                    nib = [[NSBundle mainBundle] loadNibNamed:@"RightMenuCell" owner:self options:nil];
                else
                    nib = [[NSBundle mainBundle] loadNibNamed:@"RightMenuCell_iPad" owner:self options:nil];
                
                for (id oneObject in nib) if ([oneObject isKindOfClass:[RightMenuCell class]])
                    cell = (RightMenuCell *)oneObject;
                
                //cell = [nib objectAtIndex:0];
                cell.showsReorderControl = NO;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=[UIColor clearColor];   //darkGrayColor
            }
            if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN)){
                cell.lblTitle.font=[UIFont fontWithName:@"Montserrat-Bold" size:13.0];
            }
            else{
                cell.lblTitle.font=[UIFont fontWithName:@"Montserrat-Bold" size:16.0];
            }
            
            cell.lblTitle.text = [self.arrRightMenuList objectAtIndex:intCurrentRow];
            if(intCurrentRow == appDelegate.intMenuSelectedIndexNo){
                [cell.lblIsSelected setBackgroundColor:[UIColor colorWithRed:26.0/255.0 green:161.0/255.0 blue:225.0/255.0 alpha:1.0]];
                [cell.btnMenu setEnabled:FALSE];
            }
            else{
                [cell.lblIsSelected setBackgroundColor:[UIColor clearColor]];
                [cell.btnMenu setEnabled:TRUE];
            }
            
            [cell.btnMenu setTag:indexPath.row];
            [cell.btnMenu addTarget:self action:@selector(btnTappedMenuLinks:) forControlEvents:UIControlEventTouchDown];
            
            return cell;
        }
    }
     */
}

#pragma mark - Menu Tapped
-(IBAction)btnTappedMenuLinks:(id)sender
{
    /*
    if(isProfileMenuShow && !isMailMenuShow && ([sender tag]<[self.arrProfileMenuList count]))
    {
        appDelegate.intMenuSelectedIndexNo = -1;
        appDelegate.intMailSubMenuSelectedIndexNo = -1;
        appDelegate.intProfileSubMenuSelectedIndexNo = [sender tag];
        
        NSLog(@"%@", [self.arrProfileMenuList objectAtIndex:[sender tag]]);
        
        switch ([sender tag]) {
            case 0:	//Profile
            {
                //NSLog(@"Profile");
            }
                break;
            case 1:	//Membership Plan
            {
                //NSLog(@"Membership Plan");
            }
                break;
            case 2:	//Edit Password
            {
                //NSLog(@"Edit Password");
            }
                break;
            case 3:	//Logout
            {
                //NSLog(@"Logout");
                [FunctionManager gotoBack:self];
            }
                break;
        }
    }
    else if(isMailMenuShow && !isProfileMenuShow && ([sender tag]<[self.arrMailMenuList count]))
    {
        appDelegate.intMenuSelectedIndexNo = -1;
        appDelegate.intProfileSubMenuSelectedIndexNo = -1;
        appDelegate.intMailSubMenuSelectedIndexNo = [sender tag];
        
        NSLog(@"%@", [self.arrMailMenuList objectAtIndex:[sender tag]]);
        
        switch ([sender tag]) {
            case 0:	//Inbox
            {
                //NSLog(@"Inbox");
            }
                break;
            case 1:	//Sent Item
            {
                //NSLog(@"Sent Item");
            }
                break;
        }
    }
    else
    {
        appDelegate.intProfileSubMenuSelectedIndexNo = -1;
        appDelegate.intMailSubMenuSelectedIndexNo = -1;
        
        int intCurrentRow = 0;
        
        if(isProfileMenuShow && !isMailMenuShow)
            intCurrentRow = [sender tag]-[self.arrProfileMenuList count];
        else if(isMailMenuShow && !isProfileMenuShow)
            intCurrentRow = [sender tag]-[self.arrMailMenuList count];
        else
            intCurrentRow = [sender tag];
        
        appDelegate.intMenuSelectedIndexNo = intCurrentRow;
        
        NSLog(@"%@", [self.arrRightMenuList objectAtIndex:intCurrentRow]);
        
        UINavigationController *navigationController;
        switch (intCurrentRow) {
            case 0:	//Dashboard
            {
                navigationController = [[UINavigationController alloc] initWithRootViewController:objDashboardViewController];
                self.slidingViewController.topViewController = objDashboardViewController;
            }
                break;
            case 1:	//Playlist
            {
                if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
                {
                    navigationController = [[UINavigationController alloc] initWithRootViewController:objPlaylistViewController];
                    self.slidingViewController.topViewController = objPlaylistViewController;
                }
                else{
                    navigationController = [[UINavigationController alloc] initWithRootViewController:objMyPlaylistViewController];
                    self.slidingViewController.topViewController = objMyPlaylistViewController;
                }
            }
                break;
            case 2:	//Inventory
            {
                //NSLog(@"Inventory");
            }
                break;
            case 3:	//Add a Work
            {
                //NSLog(@"Add a Work");
                //navigationController = [[UINavigationController alloc] initWithRootViewController:objAddAWorkViewController];
                //self.slidingViewController.topViewController = objAddAWorkViewController;
            }
                break;
            case 4:	//LFP Vault
            {
                //NSLog(@"LFP Vault");
            }
                break;
            case 5:	//Sell a Work
            {
                //NSLog(@"Sell a Work");
                //navigationController = [[UINavigationController alloc] initWithRootViewController:objSellAWorkViewController];
                //self.slidingViewController.topViewController = objSellAWorkViewController;
            }
                break;
            case 6:	//Trace
            {
                //NSLog(@"Trace");
            }
                break;
            case 7:	//Affiliates
            {
                //NSLog(@"Affiliates");
            }
                break;
            case 8:	//ArtRent
            {
                //NSLog(@"ArtRent");
            }
                break;
            case 9:	//Exhibitions
            {
                //NSLog(@"Exhibitions");
            }
                break;
            case 10:    //Fair Art Trade
            {
                //NSLog(@"Fair Art Trade");
            }
                break;
            case 11:	//Documents
            {
                //NSLog(@"Documents");
            }
                break;
            case 12:	//Backups
            {
                //NSLog(@"Backups");
            }
                break;
            case 13:	//Audit Reporting
            {
                //NSLog(@"Audit Reporting");
            }
                break;
        }
        
        //if(appDelegate.intMenuSelectedIndexNo==0 || appDelegate.intMenuSelectedIndexNo==1 || appDelegate.intMenuSelectedIndexNo==3 || appDelegate.intMenuSelectedIndexNo==5){
        if(appDelegate.intMenuSelectedIndexNo==0 || appDelegate.intMenuSelectedIndexNo==1){
            
            [navigationController setNavigationBarHidden:YES];
            
            //slidingViewController.topViewController = navigationController; //objNotificationViewController
            
            //[slidingViewController.view addGestureRecognizer:slidingViewController.panGesture];
            //[self.navigationController pushViewController:slidingViewController animated:YES];
            
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
        }
    }
    */
    
    [_tblRightMenuList reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
