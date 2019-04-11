//
//  DBSqlite.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/9.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "DBSqlite.h"
#import <sqlite3.h>

@implementation DBSqlite

static sqlite3 *db = nil;

+ (instancetype)shareManager {
    static DBSqlite *sqlite = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sqlite = [[DBSqlite alloc] init];
        [DBSqlite createTable];
    });
    return sqlite;
}

+ (void)createTable {
    NSString *dbPath = [DBSqlite path];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
        int result = sqlite3_open([dbPath UTF8String], &db);
        if (result == SQLITE_OK) {
            const char *sql = "create table if not exists t_student (id integer primary key autoincrement, name text, age integer, sex text, email text);";
            char *errorMsg = NULL;
            int sqResult = sqlite3_exec(db, sql, NULL, NULL, &errorMsg);
            if (sqResult == SQLITE_OK) {
                NSLog(@"创建表成功");
            } else {
                NSLog(@"创建失败");
            }
            
        } else {
            NSLog(@"打开数据库失败");
        }
        sqlite3_close(db);
    }
}

+ (NSString *)path {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"student.db"];
}

- (void)insertData {
    if (sqlite3_open([DBSqlite path].UTF8String, &db) == SQLITE_OK) {
        for (int i = 0; i < 10; i++) {
            int age = arc4random() % 10000;
            NSString *name = [NSString stringWithFormat:@"sqlite %d", age];
            NSString *sex = age % 2 ? @"M" : @"F";
            NSString *email = [NSString stringWithFormat:@"%@%@", name, @"@email.com"];
            NSString *sql = [NSString stringWithFormat:@"insert into t_student (name, age, sex, email) values ('%@', '%d', '%@', '%@');", name, age, sex, email];
            
            char *errorMsg = NULL;
            int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errorMsg);
            if (result == SQLITE_OK) {
                NSLog(@"添加成功");
            } else {
                NSLog(@"添加失败");
            }
        }
    } else {
        NSLog(@"打开失败");
    }
    
    sqlite3_close(db);
}

- (NSMutableArray *)searchData {
    
    NSMutableArray *students = [NSMutableArray array];
    if (sqlite3_open([DBSqlite path].UTF8String, &db) == SQLITE_OK) {
        
        const char *sql = "select id, name, age, sex, email from t_student";
        sqlite3_stmt *stmt = NULL;
        int result = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
        if (result == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSInteger ID = sqlite3_column_int(stmt, 0);
                NSInteger age = sqlite3_column_int(stmt, 2);
                NSString *sex = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
                NSString *email = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
                NSDictionary *dic = @{@"id" : @(ID), @"name" : name, @"age" : @(age), @"sex" : sex, @"email" : email};
                NSLog(@"dic = %@", dic);
                [students addObject:dic];
            }
        } else {
            NSLog(@"查询失败");
        }
    } else {
        
        NSLog(@"打开失败");
    }
    
    sqlite3_close(db);
    return students;
}

- (void)updateDataWithDic:(NSDictionary *)dic withName:(NSString *)name {
    
    if (sqlite3_open([DBSqlite path].UTF8String, &db) == SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"update t_student set name = '%@', age = '%@', sex = '%@' where name = '%@'", dic[@"name"], dic[@"age"], dic[@"sex"], name];
        char *errorMsg = NULL;
        if (sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errorMsg) == SQLITE_OK) {
            NSLog(@"修改成功");
        } else {
            NSLog(@"修改失败");
        }
    } else {
        NSLog(@"打开失败");
    }
    sqlite3_close(db);
}

- (void)deleteDataWithDic:(NSDictionary *)dic {
    if (sqlite3_open([DBSqlite path].UTF8String, &db) == SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"delete from t_student where name = '%@'", dic[@"name"]];
        char *errorMsg = NULL;
        if (sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errorMsg) == SQLITE_OK) {
            NSLog(@"删除成功");
        } else {
            NSLog(@"删除失败");
        }
    } else {
        NSLog(@"打开失败");
    }
    sqlite3_close(db);
}

@end
