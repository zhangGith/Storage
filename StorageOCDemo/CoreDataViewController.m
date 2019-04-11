//
//  CoreDataViewController.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/10.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "CoreDataViewController.h"
#import <CoreData/CoreData.h>
#import "MyStudent+CoreDataClass.h"
#import "MyClass+CoreDataClass.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController

static NSManagedObjectContext *context = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"myCore.sqlite"]];
    
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"Student" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {
        [NSException raise:@"添加数据库错误" format:@"%@", error.localizedDescription];
    }
   
    context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;
    
   
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"delete" style:UIBarButtonItemStyleDone target:self action:@selector(deleteData)];
    UIBarButtonItem *insertItem = [[UIBarButtonItem alloc] initWithTitle:@"insert" style:UIBarButtonItemStyleDone target:self action:@selector(insert:)];
    UIBarButtonItem *quaryItem = [[UIBarButtonItem alloc] initWithTitle:@"quary" style:UIBarButtonItemStyleDone target:self action:@selector(quaryData)];
    UIBarButtonItem *updateItem = [[UIBarButtonItem alloc] initWithTitle:@"update" style:UIBarButtonItemStyleDone target:self action:@selector(updateData)];
    self.navigationItem.rightBarButtonItems = @[deleteItem, insertItem, quaryItem, updateItem];

}

- (void)insert:(id)sender {
    MyClass *class = [NSEntityDescription insertNewObjectForEntityForName:@"MyClass" inManagedObjectContext:context];
    class.class_id = 1;
    class.name = @"万花";
    
    for (int i = 0; i < 10; i++) {
        int age = arc4random() % 10000;
        NSString *name = [NSString stringWithFormat:@"today%d", age];
        MyStudent *student = [NSEntityDescription insertNewObjectForEntityForName:@"MyStudent" inManagedObjectContext:context];
        student.name = name;
        student.age = age;
        student.class_id = 1;
        student.grade = class;
    }
    
    NSError *eror = nil;
    BOOL suc = [context save:&eror];
    if (!suc) {
        [NSException raise:@"访问失败" format:@"%@", eror.localizedDescription];
    }
}

- (void)quaryData {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"MyStudent" inManagedObjectContext:context];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"grade.class_id = 1"];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    // 遍历数据
    for (MyStudent *obj in objs) {
        NSLog(@"name = %@, age = %d", obj.name, obj.age);
    }
}

- (void)deleteData {
    // 1.根据Entity名称和NSManagedObjectContext通过谓语取出符合的Entity集合
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MyStudent"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name = %@", @"today7365"];
    NSArray *objs = [context executeFetchRequest:fetchRequest error:nil];
    
    // 2.删除集合内的Entity
    for (MyStudent *student in objs) {
        [context deleteObject:student];
    }
    
    // 3.保存修改
    NSError *error = nil;
    BOOL result = [context save:&error];
    if (result) {
        NSLog(@"保存成功...");
    } else {
        NSLog(@"保存失败：%@", error);
    }
}

- (void)updateData {
    // 1.根据Entity名称和NSManagedObjectContext通过谓语取出符合的Entity集合
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MyStudent"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"age > 1000"];
    NSArray *objs = [context executeFetchRequest:fetchRequest error:nil];
    
    // 2.修改Entity
    MyStudent *student = [objs lastObject];
    student.age = 25;
    
    // 3.保存修改
    NSError *error = nil;
    BOOL result = [context save:&error];
    if (result) {
        NSLog(@"保存成功...");
    } else {
        NSLog(@"保存失败：%@", error);
    }
}

@end
