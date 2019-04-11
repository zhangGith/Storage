//
//  StorageViewController.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/8.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "StorageViewController.h"
#import "DBSqlite.h"
#import "FMDBManager.h"

@interface StorageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *sex;

@end

@implementation StorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (_dic) {
        _name.text = _dic[@"name"];
        _age.text = [NSString stringWithFormat:@"%@", _dic[@"age"]];
        _sex.text = _dic[@"sex"];
    }
}
- (IBAction)save:(id)sender {
    
    
    
    if (_name.text.length && _age.text.length && _sex.text.length) {

        NSDictionary *dic = @{@"id" : _dic[@"id"], @"name" : _name.text, @"age" : @([_age.text integerValue]), @"sex" : _sex.text, @"email" : _dic[@"email"]};
        [FMDBManager updateDataWithDic:dic];
        
//        [[DBSqlite shareManager] updateDataWithDic:dic withName:_dic[@"name"]];
    /*
        if ([self.type isEqualToString:@"archiver"]) {
            NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"demo.archiver"];
            NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
            NSMutableArray *archiverArr = [NSMutableArray arrayWithArray:arr];
            if (_dic) {
                [archiverArr replaceObjectAtIndex:self.index withObject:dic];
            } else {
                [archiverArr addObject:dic];
            }
            [NSKeyedArchiver archiveRootObject:archiverArr toFile:plistPath];
            
        } else
        
        if ([self.type isEqualToString:@"plist"]) {
            
            NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"demo.plist"];
            NSMutableArray *plistArr;
            if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
                plistArr = [NSMutableArray array];
            } else {
                
                plistArr = [NSMutableArray arrayWithContentsOfFile:plistPath];
            }
            if (!_dic) {
                [plistArr addObject:dic];
            } else {
                [plistArr replaceObjectAtIndex:self.index withObject:dic];
            }
            [plistArr writeToFile:plistPath atomically:YES];
        } else {
            NSMutableArray *udArr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"person"]];

            if (_dic) {
                [udArr replaceObjectAtIndex:self.index withObject:dic];
            } else {
                [udArr addObject:dic];
            }
            [[NSUserDefaults standardUserDefaults] setObject:udArr forKey:@"person"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        */
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSLog(@"为正确输入");
    }
    
}



@end
