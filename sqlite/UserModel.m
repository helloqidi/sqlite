//
//  UserModel.m
//  sqlite
//
//  Created by 张 启迪 on 13-10-18.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _name = [attributes valueForKeyPath:@"name"];
    _email = [attributes valueForKeyPath:@"email"];
    
    return self;
}


@end
