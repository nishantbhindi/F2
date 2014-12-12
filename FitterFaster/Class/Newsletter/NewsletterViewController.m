//
//  NewsletterViewController.m
//  FitterFaster
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "NewsletterViewController.h"

@interface NewsletterViewController ()

@end

@implementation NewsletterViewController

@synthesize arrNewsletter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.slidingViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self fetchNewsletter];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.slidingViewController.view removeGestureRecognizer:self.slidingViewController.panGesture];
}

#pragma mark - Initialize Page Data
-(void)setInitialParameter{
    [self resetData];
    [self bindDefaultData];
    
    [FunctionManager setDefaultTableViewStyle:_tblNewsletter delegate:self];
    
    self.arrNewsletter = [[NSMutableArray alloc] init];
    
    Newsletter *objNewsletter = [[Newsletter alloc] init];
    objNewsletter.intNewsletterID = 1;
    objNewsletter.strTitle = @"Tips about day!";
    objNewsletter.strSmallDesc = @"Take low nutritial food for good health. Take low nutritial food for good health.";
    objNewsletter.strLongDesc = @"Long Description...";
    objNewsletter.strUrl = @"http://www.FitterFaster.com/";
    objNewsletter.strDateTime = @"2014-09-05";
    [self.arrNewsletter addObject:objNewsletter];
     
    Newsletter *objNewsletter2 = [[Newsletter alloc] init];
    objNewsletter2.intNewsletterID = 2;
    objNewsletter2.strTitle = @"Special Note for You!";
    objNewsletter2.strSmallDesc = @"Take low nutritial food for good health.";
    objNewsletter2.strLongDesc = @"Long Description...";
    objNewsletter2.strUrl = @"http://www.google.com/";
    objNewsletter2.strDateTime = @"2014-10-10";
    [self.arrNewsletter addObject:objNewsletter2];
    
    Newsletter *objNewsletter3 = [[Newsletter alloc] init];
    objNewsletter3.intNewsletterID = 3;
    objNewsletter3.strTitle = @"Tips about day!";
    objNewsletter3.strSmallDesc = @"Take low nutritial food for good health. Take low nutritial food for good health.";
    objNewsletter3.strLongDesc = @"Long Description...";
    objNewsletter3.strUrl = @"http://www.google.com/";
    objNewsletter3.strDateTime = @"2014-11-08";
    [self.arrNewsletter addObject:objNewsletter3];
    
    Newsletter *objNewsletter4 = [[Newsletter alloc] init];
    objNewsletter4.intNewsletterID = 4;
    objNewsletter4.strTitle = @"Special Note for You!";
    objNewsletter4.strSmallDesc = @"Take low nutritial food for good health.";
    objNewsletter4.strLongDesc = @"Long Description...";
    objNewsletter4.strUrl = @"http://www.FitterFaster.com/";
    objNewsletter4.strDateTime = @"2014-12-10";
    [self.arrNewsletter addObject:objNewsletter4];
    
    [FunctionManager checkRecordAvailable:self.arrNewsletter withTable:_tblNewsletter withLabel:_lblNoRecords];
}
#pragma mark - Reset
-(void)resetData{
}
#pragma mark - Bind Default Data
-(void)bindDefaultData{
    _lblNoRecords.text = msgNoDataFound;
}

#pragma mark - Fetch Cart
-(void)fetchNewsletter{
    /*
    if(self.arrNewsletter.count>0)
        [self.arrNewsletter removeAllObjects];
    
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"getNewsletter";
    
    parameters[@"userid"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intUserID];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkCartResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
        //NSLog(@"ERROR: %@", [error localizedDescription]);
    }];
    */
}
-(void)checkCartResponse:(NSDictionary *)pdicResponse{
    /*
    NSString *strCurr = (NSString*)[pdicResponse objectForKey:@"currency_symbol"];
    
    NSDictionary *dicCartInfo = (NSDictionary*)[pdicResponse objectForKey:@"cart_info"];
    NSDictionary *dicShippingInfo = (NSDictionary*)[dicCartInfo objectForKey:@"shipping_address"];  //street, city, postcode, telephone
    //Difference between "shipping_address" and "billing_address"
    
    NSArray *arrProducts = (NSArray*)[dicCartInfo objectForKey:@"items"];
    for(int i=0;i<arrProducts.count;i++){
        NSDictionary *dicProduct = [arrProducts objectAtIndex:i];
        
        Newsletter *objNewsletter = [[Newsletter alloc] init];
        objNewsletter.intProductID = [[dicProduct objectForKey:@"product_id"] intValue];
        objNewsletter.strTitle = [dicProduct objectForKey:@"name"];
        objNewsletter.strPrice = [dicProduct objectForKey:@"price"];
        
        objNewsletter.strCurrency = strCurr;
        objNewsletter.intCartQty = [[dicProduct objectForKey:@"qty"] intValue];
        objNewsletter.strRowTotal = [dicProduct objectForKey:@"row_total"];
        
        objNewsletter.strVolume = [dicProduct objectForKey:@"alcohol_by_volume"];
        objNewsletter.strServing = [dicProduct objectForKey:@"units_per_serving"];
        objNewsletter.strSize = [dicProduct objectForKey:@"size"];
        objNewsletter.strPhotoUrl = [dicProduct objectForKey:@"image_url"];
        [self.arrNewsletter addObject:objNewsletter];
    }
    
    
    NSArray *arrTotal = (NSArray*)[pdicResponse objectForKey:@"cart_totals"];
    NSDictionary *dicTotal = [arrTotal objectAtIndex:0];
    NSDictionary *dicDelivery = [arrTotal objectAtIndex:1];
    NSDictionary *dicGrandTotal = [arrTotal objectAtIndex:2];
    
    _lblTotalTitle.text = [dicTotal objectForKey:@"title"];
    //_lblTotal.text = [dicTotal objectForKey:@"amount"];
    _lblTotal.text = [NSString stringWithFormat:@"%@%.2f", strCurr, [[dicTotal objectForKey:@"amount"] floatValue]];
    
    _lblDeliveryChargeTitle.text = [dicDelivery objectForKey:@"title"];
    //_lblDeliveryCharge.text = [dicDelivery objectForKey:@"amount"];
    _lblDeliveryCharge.text = [NSString stringWithFormat:@"%@%.2f", strCurr, [[dicDelivery objectForKey:@"amount"] floatValue]];
    
    _lblGrandTotalTitle.text = [dicGrandTotal objectForKey:@"title"];
    //_lblGrandTotal.text = [dicGrandTotal objectForKey:@"amount"];
    _lblGrandTotal.text = [NSString stringWithFormat:@"%@%.2f", strCurr, [[dicGrandTotal objectForKey:@"amount"] floatValue]];
    
    [_tblNewsletter reloadData];
    [FunctionManager checkRecordAvailable:self.arrNewsletter withTable:_tblNewsletter withLabel:_lblNoRecords];
    */
}

#pragma mark - UITableView Delegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrNewsletter.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsletterCell";
    NewsletterCell *cell = (NewsletterCell *)[_tblNewsletter dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)	{
        NSArray* nib;
        if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
            nib = [[NSBundle mainBundle] loadNibNamed:@"NewsletterCell" owner:self options:nil];
        else
            nib = [[NSBundle mainBundle] loadNibNamed:@"NewsletterCell_iPad" owner:self options:nil];
        
        for (id oneObject in nib) if ([oneObject isKindOfClass:[NewsletterCell class]])
            cell = (NewsletterCell *)oneObject;
        
        //cell = [nib objectAtIndex:0];
        cell.showsReorderControl = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];   //darkGrayColor
    }
    /*
     [cell.btnRemove.layer setCornerRadius:3.0];
     [cell.btnRemove.layer setBorderColor:[UIColor lightGrayColor].CGColor];
     [cell.btnRemove.layer setBorderWidth: 2.0];
     cell.btnRemove.clipsToBounds = YES;
     */
    
    Newsletter *objNewsletterTmp = [self.arrNewsletter objectAtIndex:indexPath.row];
    
    cell.lblTitle.text = objNewsletterTmp.strTitle;
    cell.lblSmallDesc.text = objNewsletterTmp.strSmallDesc;
    
    NSString *strDisplayDt = [FunctionManager getFormatedDate:objNewsletterTmp.strDateTime withDateFormat:g_DateFormatDefault withDisplayFormat:g_DateFormatDisplay2];    //g_DateTimeFormatDefaultZone
    cell.lblDate.text = strDisplayDt;
    
    [cell.btnCell setTag:indexPath.row];
    [cell.btnCell addTarget:self action:@selector(btnTappedCell:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Newsletter *objNewsletterTmp = [self.arrNewsletter objectAtIndex:indexPath.row];
    NSLog(@"%@", objNewsletterTmp.strTitle);
    
    NewsletterDetailViewController *objNewsletterDetailViewController;
    objNewsletterDetailViewController = [[[NewsletterDetailViewController alloc] initWithNibName:@"NewsletterDetailViewController" bundle:nil] autorelease];
    
    //    if(g_IS_IPHONE_6PLUS_SCREEN)
    //        objNewsletterDetailViewController = [[[NewsletterDetailViewController alloc] initWithNibName:@"NewsletterDetailViewController6P" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_6_SCREEN)
    //        objNewsletterDetailViewController = [[[NewsletterDetailViewController alloc] initWithNibName:@"NewsletterDetailViewController6" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_5_SCREEN)
    //        objNewsletterDetailViewController = [[[NewsletterDetailViewController alloc] initWithNibName:@"NewsletterDetailViewController" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_4_SCREEN)
    //        objNewsletterDetailViewController = [[[NewsletterDetailViewController alloc] initWithNibName:@"NewsletterDetailViewController4" bundle:nil] autorelease];
    //    //else if(g_IS_IPAD)
    //        //objNewsletterDetailViewController = [[[NewsletterDetailViewController alloc] initWithNibName:@"NewsletterDetailViewControlleriPad" bundle:nil] autorelease];
    //    else
    //        objNewsletterDetailViewController = [[[NewsletterDetailViewController alloc] initWithNibName:@"NewsletterDetailViewController4" bundle:nil] autorelease];    
    
    objNewsletterDetailViewController.objNewsletter = objNewsletterTmp;
    [self.navigationController pushViewController:objNewsletterDetailViewController animated:YES];
}
#pragma mark Button Tapped Cell
- (IBAction)btnTappedCell:(id)sender{
    Newsletter *objNewsletterTmp = [self.arrNewsletter objectAtIndex:[sender tag]];
    NSLog(@"%@", objNewsletterTmp.strTitle);
}

#pragma mark - Btn Tapped Feedback
-(IBAction)btnTappedFeedback:(id)sender
{
}

#pragma mark - Click On Menu Items
-(IBAction)displayLeftMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [_lblNoRecords release];
    
    if(self.arrNewsletter.count>0)
        [self.arrNewsletter removeAllObjects];
    [self.arrNewsletter release];
    
    [_tblNewsletter release];
    
    [super dealloc];
}

@end
