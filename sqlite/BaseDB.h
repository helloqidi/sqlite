//
//  BaseDB.h
//  sqlite
//
//  Created by 张 启迪 on 13-10-18.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BaseDB : NSObject

- (BOOL)createTable:(NSString *)sql;

- (BOOL)dealData:(NSString *)sql paramsarray:(NSArray *)params;

- (NSMutableArray *)selectData:(NSString *)sql columns:(int)number;

@end
