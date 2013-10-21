//
//  UserModel.h
//  sqlite
//
//  Created by 张 启迪 on 13-10-18.
//  Copyright (c) 2013年 张 启迪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
