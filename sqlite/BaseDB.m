//
//  BaseDB.m
//  sqlite
//
//  Created by 张 启迪 on 13-10-18.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "BaseDB.h"

#define kFilename @"data.sqlite"

@implementation BaseDB

- (NSString *)filePath
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",kFilename];
    return filePath;
}

//创建表
- (BOOL)createTable:(NSString *)sql
{
    sqlite3 *sqlite = nil;
    
    //打开数据库
    int result = sqlite3_open([self.filePath UTF8String],&sqlite);
    if (result != SQLITE_OK){
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return NO;
    }
    
    char *errmsg = nil;
    result = sqlite3_exec(sqlite,[sql UTF8String],NULL,NULL,&errmsg);
    if (result != SQLITE_OK){
        NSLog(@"创建表失败:%s",errmsg);
        sqlite3_close(sqlite);
        return NO;
    }
    
    //关闭数据库
    sqlite3_close(sqlite);
    return YES;
}



//增删改 操作
- (BOOL)dealData:(NSString *)sql paramsarray:(NSArray *)params
{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //打开数据库
    int result = sqlite3_open([self.filePath UTF8String],&sqlite);
    if (result != SQLITE_OK){
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return NO;
    }
    
    //编译sql语句
    result  = sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK){
        NSLog(@"sql语句编译失败");
        sqlite3_close(sqlite);
        return NO;
    }
    
    //绑定数据
    for (int i=0;i<params.count;i++){
        NSString *value = [params objectAtIndex:i];
        //默认字段都是text类型
        sqlite3_bind_text(stmt,i+1,[value UTF8String],-1,NULL);
    }
    
    //执行sql语句
    result = sqlite3_step(stmt);
//    if (result != SQLITE_OK){
//        NSLog(@"sql语句执行失败");
//        sqlite3_close(sqlite);
//        return NO;
//    }
    if(result==SQLITE_ERROR || result==SQLITE_MISUSE){
        NSLog(@"sql语句执行失败");
        sqlite3_close(sqlite);
        
        return NO;
    }
    
    //关闭数据库
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    return YES;
}




//查询，返回2维数组
//返回值： [  ["字段值1"，"字段值2"],["字段值1","字段值2"],["字段值1","字段值2"]...  ]
- (NSMutableArray *)selectData:(NSString *)sql columns:(int)number
{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //打开数据库
    int result = sqlite3_open([self.filePath UTF8String],&sqlite);
    if (result != SQLITE_OK){
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return nil;
    }
    
    //编译sql语句
    result  = sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK){
        NSLog(@"sql语句编译失败");
        sqlite3_close(sqlite);
        return nil;
    }
    
    //执行查询
    result = sqlite3_step(stmt);
    NSMutableArray *data = [NSMutableArray array];
    while (result == SQLITE_ROW){
        NSMutableArray *row = [NSMutableArray arrayWithCapacity:number];
        for (int i=0;i<number;i++){
            //默认都是text类型字段
            char *columnText = sqlite3_column_text(stmt,i);
            NSString *string = [NSString stringWithCString:columnText encoding:NSUTF8StringEncoding];
            [row addObject:string];
        }
        result = sqlite3_step(stmt);
        [data addObject:row];
    }
    
    //关闭
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return data;
    
}

@end
