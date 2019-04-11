//
//  MyStudent+CoreDataProperties.m
//  
//
//  Created by Block on 2019/4/11.
//
//

#import "MyStudent+CoreDataProperties.h"

@implementation MyStudent (CoreDataProperties)

+ (NSFetchRequest<MyStudent *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MyStudent"];
}

@dynamic age;
@dynamic card;
@dynamic class_id;
@dynamic name;
@dynamic grade;

@end
