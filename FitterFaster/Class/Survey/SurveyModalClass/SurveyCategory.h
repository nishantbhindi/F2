//
//  SurveyCategory.h
//  FitterFaster
//
//  Created by WebInfoways on 20/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyCategory : NSObject {
    int intCategoryID;
    NSString *strTitle;
    
    NSMutableArray *arrQuesAns;
}
@property(nonatomic) int intCategoryID;
@property(nonatomic, retain) NSString *strTitle;

@property(nonatomic, retain) NSMutableArray *arrQuesAns;

@end
