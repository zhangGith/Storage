//
//  FMDBManager.h
//  StorageOCDemo
//
//  Created by Block on 2019/4/9.
//  Copyright © 2019年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject

+ (void)insertDataWithInfo:(NSDictionary *)dic;
+ (void)updateDataWithDic:(NSDictionary *)dic;
+ (void)deleteDataWithDic:(NSDictionary *)dic;
+ (void)quaryDataWithCompletion:(void (^)(NSArray *arr))comletion;
+ (void)dropTable;

@end
