//
//  MyClass+CoreDataProperties.m
//  
//
//  Created by Block on 2019/4/10.
//
//

#import "MyClass+CoreDataProperties.h"

@implementation MyClass (CoreDataProperties)

+ (NSFetchRequest<MyClass *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MyClass"];
}

@dynamic class_id;
@dynamic name;
@dynamic student;

@end
