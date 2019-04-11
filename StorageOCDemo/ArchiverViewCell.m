//
//  ArchiverViewCell.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/8.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "ArchiverViewCell.h"

@implementation ArchiverViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.name.text = dic[@"name"];
    self.age.text = dic[@"age"];
    self.sex.text = dic[@"sex"];
}

- (void)setPerson:(Person *)person {
    _person = person;
    self.name.text = person.name;
    self.age.text = [NSString stringWithFormat:@"%ld", (long)person.age];
    self.sex.text = person.sex;
}

@end
