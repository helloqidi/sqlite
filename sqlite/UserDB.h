//
//  UserDB.h
//  sqlite
//
//  Created by 张 启迪 on 13-10-18.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "BaseDB.h"
#import "UserModel.h"

@interface UserDB : BaseDB

+ (UserDB *)sharedDB;

- (BOOL)createTable;

- (BOOL)insertTable:(UserModel *)userModel;

- (NSMutableArray *)selectTable;

@end
