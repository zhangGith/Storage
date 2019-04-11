//
//  ViewController.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/8.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "ViewController.h"
#import "PlistTableViewController.h"
#import "ArchiverViewController.h"
#import "SqliteViewController.h"
#import "CoreDataViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlistTableViewController *plistVC = (PlistTableViewController *)(segue.destinationViewController);
    plistVC.storageType = segue.identifier;
}

- (IBAction)keyArchiverClick:(id)sender {
    
//    PlistTableViewController *plistVC = [self.storyboard instantiateViewControllerWithIdentifier:@"plist"];
//    plistVC.storageType = @"archiver";
//    [self.navigationController pushViewController:plistVC animated:YES];
    
    ArchiverViewController *arVC = [ArchiverViewController new];
    [self.navigationController pushViewController:arVC animated:YES];
    
}
- (IBAction)sqlClick:(id)sender {
//    [self.navigationController pushViewController:[SqliteViewController new] animated:YES];
}
- (IBAction)fmdbClick:(id)sender {
    [self.navigationController pushViewController:[SqliteViewController new] animated:YES];

}
- (IBAction)coreDataClick:(id)sender {
    [self.navigationController pushViewController:[CoreDataViewController new] animated:YES];
}

@end
