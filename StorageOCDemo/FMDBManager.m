//
//  FMDBManager.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/9.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "FMDBManager.h"
#import <fmdb/FMDB.h>

@interface FMDBManager ()

@property (nonatomic, strong) FMDatabaseQueue *dataBaseQueue;

@end

@implementation FMDBManager

+ (instancetype)shareManager {
    static FMDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self createTable];
    }
    return self;
}

- (NSString *)path {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"myStudent.sqlite"];
}

- (FMDatabaseQueue *)dataBaseQueue {
    if (!_dataBaseQueue) {
//        if (![[NSFileManager defaultManager] fileExistsAtPath:[self path]]) {
//        }
        _dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self path]];
    }
    return _dataBaseQueue;
}


- (void)createTable {
    
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            BOOL result = [db executeUpdate:@"create table if not exists t_student (id integer primary key autoincrement, name text not NULL, age integer, sex text, email text);"];
            if (!result) {
                NSLog(@"创建失败");
            } else {
                NSLog(@"创建成功");
            }
            [db close];
        } else {
            NSLog(@"打开失败");
        }
    }];
    
}

+ (void)insertDataWithInfo:(NSDictionary *)dic {
    [[FMDBManager shareManager] createTable];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *name = dic[@"name"];
        if (name) {
            FMDatabaseQueue *dbQueue = [FMDBManager shareManager].dataBaseQueue;
            [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
                if ([db open]) {
                    NSString *sql = [NSString stringWithFormat:@"insert or replace into t_student (name, age, sex, email) values (?, ?, ?, ?)"];
                    
                    BOOL res = [db executeUpdate:sql withArgumentsInArray:@[name, dic[@"age"], dic[@"sex"], dic[@"email"]]];
                    if (res) {
                        NSLog(@"添加成功");
                    } else {
                        NSLog(@"添加失败");
                    }
                    [db close];
                } else {
                    NSLog(@"打开失败");
                }
            }];
        }
    });
}

+ (void)updateDataWithDic:(NSDictionary *)dic {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *user_id = dic[@"id"];
        if (user_id) {
            FMDatabaseQueue *dbQueue =[FMDBManager shareManager].dataBaseQueue;
            [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
                if ([db open]) {
                    NSString *sql = @"update t_student set name = ?, age = ?, sex = ?, email = ? where id = ?";
                    BOOL res = [db executeUpdate:sql withArgumentsInArray:@[dic[@"name"], dic[@"age"], dic[@"sex"], dic[@"email"], user_id]];
                    if (res) {
                        NSLog(@"update成功");
                    } else {
                        NSLog(@"update失败");
                    }
                    [db close];
                } else {
                    NSLog(@"打开失败");
                }
            }];
        }
    });
}

+ (void)deleteDataWithDic:(NSDictionary *)dic {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *userID = dic[@"id"];
        if (userID) {
            FMDatabaseQueue *dbQueue =[FMDBManager shareManager].dataBaseQueue;
            [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
                if ([db open]) {
                    NSString *sql = @"delete from t_student where id = ?";
                    BOOL res = [db executeUpdate:sql withArgumentsInArray:@[userID]];
                    if (res) {
                        NSLog(@"删除成功");
                    } else {
                        NSLog(@"删除失败");
                    }
                    [db close];
                } else {
                    NSLog(@"打开失败");
                }
            }];
        }
    });
}

+ (void)quaryDataWithCompletion:(void (^)(NSArray *arr))comletion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FMDatabaseQueue *dbQueue =[FMDBManager shareManager].dataBaseQueue;
        [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            if ([db open]) {
                FMResultSet *set = [db executeQuery:@"select * from t_student"];
                NSMutableArray *arr = [NSMutableArray array];
                while ([set next]) {
                    NSInteger user_id = [set intForColumnIndex:0];
                    NSString *name = [set stringForColumn:@"name"];
                    NSInteger age = [set intForColumn:@"age"];
                    NSString *sex = [set stringForColumn:@"sex"];
                    NSString *email = [set stringForColumn:@"email"];
                    NSDictionary *dic = @{@"id" : @(user_id), @"name" : name, @"age" : @(age), @"sex" : sex, @"email" : email};
                    [arr addObject:dic];
                }
                [db close];
                
                !comletion ? : comletion(arr);
            }
        }];
    });
}

+ (void)dropTable {
    FMDatabaseQueue *dbQueue =[FMDBManager shareManager].dataBaseQueue;
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            NSString *sql = @"drop table t_student";
            BOOL res = [db executeUpdate:sql];
            if (res) {
                NSLog(@"删除成功");
            } else {
                NSLog(@"删除失败");
            }
            [db close];
        } else {
            NSLog(@"open error");
        }
    }];
}

@end
