//
//  ArchiverViewController.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/8.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "ArchiverViewController.h"
#import "ArchiverViewCell.h"
#import "Person.h"
@interface ArchiverViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self .navigationItem.title = @"ar";
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        int age = arc4random() % 1000;
        Person *per = [[Person alloc] init];
        per.name = [NSString stringWithFormat:@"%@%d", @"Arc", age];
        per.age = age;
        per.sex = age % 2 ? @"M" : @"F";
        [arr addObject:per];
    }
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"arhi.archiver"];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *key = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [key encodeObject:arr forKey:@"archiverKey"];
    [key finishEncoding];
    [data writeToFile:path atomically:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ArchiverViewCell" bundle:nil] forCellReuseIdentifier:@"archiverCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"arhi.archiver"];
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    NSKeyedUnarchiver *unkey = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray *arr = [unkey decodeObjectForKey:@"archiverKey"];
    self.dataSource = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArchiverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"archiverCell" forIndexPath:indexPath];
    
    Person *per = self.dataSource[indexPath.row];
    
    cell.person = per;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
