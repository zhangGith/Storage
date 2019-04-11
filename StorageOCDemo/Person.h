//
//  Person.h
//  StorageOCDemo
//
//  Created by Block on 2019/4/8.
//  Copyright © 2019年 Block. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *sex;


@end
