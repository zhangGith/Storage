//
//  PlistViewCell.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/8.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "PlistViewCell.h"

@implementation PlistViewCell

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.name.text = dic[@"name"];
    self.age.text = dic[@"age"];
    self.sex.text = dic[@"sex"];
}

@end
