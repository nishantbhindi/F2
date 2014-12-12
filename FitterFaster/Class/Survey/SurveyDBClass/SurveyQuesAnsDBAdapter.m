//
//  SurveyQuesAnsDBAdapter.m
//  FitterFaster
//
//  Created by WebInfoways on 21/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SurveyQuesAnsDBAdapter.h"

static sqlite3_stmt *select_statement = nil;
static sqlite3_stmt *insert_statement = nil;
static sqlite3_stmt *update_statement = nil;
//static sqlite3_stmt *delete_statement = nil;

@implementation SurveyQuesAnsDBAdapter

#pragma mark - Insert
-(int)insertSurveyQuesAns:(SurveyQuesAns *)pobjSurveyQuesAns withCategoryID:(int)pintCategoryId{
    // Open the database. The database was prepared outside the application.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    const char *insertSql;
    insertSql = nil;
    insert_statement = nil;
    
    if(insert_statement == nil)
    {
        insertSql = "INSERT INTO tblSurveyQuestion (CategoryID, Question) VALUES(?, ?)";
        if(sqlite3_prepare_v2(appDelegate.objDBAdapter.database, insertSql, -1, &insert_statement, NULL) != SQLITE_OK){
            NSAssert1(0, @"Error: failed to prepare insert statement with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
            return 0;
        }
        
        sqlite3_bind_int(insert_statement, 1, pintCategoryId);
        sqlite3_bind_text(insert_statement, 2, [pobjSurveyQuesAns.strQuestion UTF8String], -1, SQLITE_TRANSIENT);
    }
    //Insert the values into DB
    if(sqlite3_step(insert_statement) != SQLITE_DONE)
    {
        NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
        return 0;
    }
    else
    {
        // SQLite provides a method which retrieves the value of the most recently auto-generated primary key sequence
        // in the database. To access this functionality, the table should have a column declared of type
        // "INTEGER PRIMARY KEY"
        int primaryKey = sqlite3_last_insert_rowid(appDelegate.objDBAdapter.database);
        return primaryKey;
    }
    
    //Reset the add statement.
    sqlite3_reset(insert_statement);
    
    return 0;
}
#pragma mark - Update
-(BOOL)updateSurveyQuesAns:(SurveyQuesAns *)pobjSurveyQuesAns withCategoryID:(int)pintCategoryId{
    // Open the database. The database was prepared outside the application.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    const char *updateSql;
    updateSql = nil;
    update_statement = nil;
    
    if (update_statement == nil) {
        static char *sql = "UPDATE tblSurveyQuestion SET CategoryID=?, Question=? WHERE ID=?";
        if (sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
            return FALSE;
        }
    }
    
    sqlite3_bind_int(update_statement, 1, pintCategoryId);
    sqlite3_bind_text(update_statement, 2, [pobjSurveyQuesAns.strQuestion UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_bind_int(update_statement, 3, pobjSurveyQuesAns.intQuestionID);
    
    if (sqlite3_step(update_statement) == SQLITE_ERROR) {
        NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
        return FALSE;
    } else {
        return TRUE;
    }
    // All data for the book is already in memory, but has not be written to the database
    // Mark as hydrated to prevent empty/default values from overwriting what is in memory
    
    // Because we want to reuse the statement, we "reset" it instead of "finalizing" it.
    sqlite3_reset(update_statement);
    
    return FALSE;
}
#pragma mark - Delete
-(BOOL)deleteSurveyQuesAnsById:(int)pintSurveyQuesAnsId{
    //Delete Answer Options
    //SELECT tblSurveyAnswer.* FROM tblSurveyAnswer,tblSurveyQuestion WHERE tblSurveyAnswer.QuestionID = tblSurveyQuestion.ID AND tblSurveyQuestion.ID = 2
    NSString *strAnswer;
    const char *sqlAnswer;
    strAnswer = @"SELECT tblSurveyAnswer.* FROM tblSurveyAnswer,tblSurveyQuestion WHERE tblSurveyAnswer.QuestionID = tblSurveyQuestion.ID AND tblSurveyQuestion.ID = %d";
    strAnswer = [NSString stringWithFormat:strAnswer, pintSurveyQuesAnsId];
    sqlAnswer = [strAnswer UTF8String];
    int intAnswerDelete = [DBFunctionManager executeGeneralQuery:sqlAnswer];
    NSLog(@"Answer Delete = %d", intAnswerDelete);
    
    
    NSString *sqlString;
    const char *sql;
    sqlString = @"DELETE FROM tblSurveyQuestion WHERE ID = %d";
    sqlString = [NSString stringWithFormat:sqlString, pintSurveyQuesAnsId];
    sql = [sqlString UTF8String];
    return [DBFunctionManager executeGeneralQuery:sql];
}
#pragma mark - Select
-(void)selectSurveyQuesAnsById:(int)pintSurveyQuesAnsId :(NSMutableArray *)pArrSurveyQuesAns{
   	// Open the database. The database was prepared outside the application.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    select_statement = nil;
    NSString *strSelectQuery = [NSString stringWithFormat:@"SELECT ID, CategoryID, Question FROM tblSurveyQuestion WHERE ID=%d", pintSurveyQuesAnsId];
    const char *sqlStatement = [strSelectQuery UTF8String];
    
    if(sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sqlStatement, -1, &select_statement, NULL) == SQLITE_OK)
    {
        // Loop through the results and add them to the feeds array
        while(sqlite3_step(select_statement) == SQLITE_ROW)
        {
            SurveyQuesAns *objSurveyCategory = [[SurveyQuesAns alloc] init];
            objSurveyCategory.intQuestionID = sqlite3_column_int(select_statement, 0);
            objSurveyCategory.strQuestion = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 2)];
            [pArrSurveyQuesAns addObject:objSurveyCategory];
            [objSurveyCategory release];
        }
    }
    // Release the compiled statement from memory
    sqlite3_finalize(select_statement);
    select_statement = nil;
}
-(void)selectSurveyQuesAnsByCatId:(int)pintCategoryId :(NSMutableArray *)pArrSurveyQuesAns{
    // Open the database. The database was prepared outside the application.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    select_statement = nil;
    NSString *strSelectQuery = [NSString stringWithFormat:@"SELECT tblSurveyQuestion.Question, tblSurveyAnswer.* FROM tblSurveyCategory, tblSurveyQuestion, tblSurveyAnswer WHERE tblSurveyQuestion.CategoryID = tblSurveyCategory.ID AND tblSurveyAnswer.QuestionID = tblSurveyQuestion.ID AND tblSurveyCategory.ID = %d", pintCategoryId];
    const char *sqlStatement = [strSelectQuery UTF8String];
    
    SurveyQuesAns *objSurveyQuesAns = [[SurveyQuesAns alloc] init];
    objSurveyQuesAns.arrAnswers = [[NSMutableArray alloc] init];
    BOOL isQuesAdded = FALSE;
    
    if(sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sqlStatement, -1, &select_statement, NULL) == SQLITE_OK)
    {
        // Loop through the results and add them to the feeds array
        while(sqlite3_step(select_statement) == SQLITE_ROW)
        {
            if(!isQuesAdded){
                isQuesAdded = TRUE;
                objSurveyQuesAns.intQuestionID = sqlite3_column_int(select_statement, 2);
                objSurveyQuesAns.strQuestion = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 0)];
            }
            
            int intAnsID = sqlite3_column_int(select_statement, 1);
            NSString *strAnswer = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 3)];
            
            NSMutableDictionary *dicAnsOptions=[[NSMutableDictionary alloc] initWithCapacity:3];
            [dicAnsOptions setValue:[NSString stringWithFormat:@"%d", intAnsID] forKey:@"ID"];
            [dicAnsOptions setValue:strAnswer forKey:@"Answer"];
            [dicAnsOptions setValue:@"0" forKey:@"IsSelected"];            
            [objSurveyQuesAns.arrAnswers addObject:dicAnsOptions];
        }
    }
    
    [pArrSurveyQuesAns addObject:objSurveyQuesAns];
    [objSurveyQuesAns release];
    
    // Release the compiled statement from memory
    sqlite3_finalize(select_statement);
    select_statement = nil;
}

@end
