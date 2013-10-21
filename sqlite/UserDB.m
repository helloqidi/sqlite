//
//  UserDB.m
//  sqlite
//
//  Created by 张 启迪 on 13-10-18.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "UserDB.h"

@implementation UserDB

static UserDB *sharedDB = nil;


+ (UserDB *)sharedDB
{
    if (sharedDB == nil) {
        sharedDB = [[UserDB alloc] init];
    }
    
    return sharedDB;
}


- (BOOL)createTable
{
    NSString *sql = @"CREATE TABLE user(name TEXT, email TEXT);";
    return [super createTable:sql];
}

- (BOOL)insertTable:(UserModel *)userModel
{
    NSArray *array = [NSArray arrayWithObjects:userModel.name,userModel.email, nil];
    NSString *sql = @"INSERT INTO user(name,email) VALUES(?,?);";
    return [self dealData:sql paramsarray:array];
   
}

- (NSMutableArray *)selectTable
{
    NSString *sql = @"select name,email from user;";
    NSMutableArray *array = [self selectData:sql columns:2];
    NSMutableArray *userModels = [NSMutableArray array];
    
    if (array.count <= 0) {
        return userModels;
    }
    
    for (int i=0; i<array.count; i++) {
        NSArray *data = [array objectAtIndex:i];
        UserModel *user =[[UserModel alloc] init];
        user.name = [data objectAtIndex:0];
        user.email = [data objectAtIndex:1];
        [userModels addObject:user];
    }
    
    return userModels;
}

@end
