//
//  PlistViewCell.h
//  StorageOCDemo
//
//  Created by Block on 2019/4/8.
//  Copyright © 2019年 Block. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlistViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *sex;

@property (nonatomic, copy) NSDictionary *dic;

@end
