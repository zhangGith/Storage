//
//  MyClass+CoreDataProperties.h
//  
//
//  Created by Block on 2019/4/10.
//
//

#import "MyClass+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MyClass (CoreDataProperties)

+ (NSFetchRequest<MyClass *> *)fetchRequest;

@property (nonatomic) int16_t class_id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<MyStudent *> *student;

@end

@interface MyClass (CoreDataGeneratedAccessors)

- (void)addStudentObject:(MyStudent *)value;
- (void)removeStudentObject:(MyStudent *)value;
- (void)addStudent:(NSSet<MyStudent *> *)values;
- (void)removeStudent:(NSSet<MyStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
