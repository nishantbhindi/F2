//
//  Newsletter.h
//  FitterFaster
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Newsletter : NSObject {
    int intNewsletterID;
    
    NSString *strTitle;
    NSString *strSmallDesc;
    NSString *strLongDesc;
    NSString *strUrl;
    
    NSString *strDateTime;
}
@property(nonatomic) int intNewsletterID;

@property(nonatomic, retain) NSString *strTitle;
@property(nonatomic, retain) NSString *strSmallDesc;
@property(nonatomic, retain) NSString *strLongDesc;
@property(nonatomic, retain) NSString *strUrl;

@property(nonatomic, retain) NSString *strDateTime;

@end
