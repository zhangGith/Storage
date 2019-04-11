//
//  DBSqlite.h
//  StorageOCDemo
//
//  Created by Block on 2019/4/9.
//  Copyright © 2019年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBSqlite : NSObject

+ (instancetype)shareManager;
- (void)insertData;
- (NSMutableArray *)searchData;
- (void)updateDataWithDic:(NSDictionary *)dic withName:(NSString *)name;
- (void)deleteDataWithDic:(NSDictionary *)dic;

@end
