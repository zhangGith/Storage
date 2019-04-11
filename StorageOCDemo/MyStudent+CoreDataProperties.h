//
//  MyStudent+CoreDataProperties.h
//  
//
//  Created by Block on 2019/4/10.
//
//

#import "MyStudent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MyStudent (CoreDataProperties)

+ (NSFetchRequest<MyStudent *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nonatomic) int16_t class_id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) MyClass *grade;

@end

NS_ASSUME_NONNULL_END
