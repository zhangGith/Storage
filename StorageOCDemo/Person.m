//
//  Person.m
//  StorageOCDemo
//
//  Created by Block on 2019/4/8.
//  Copyright © 2019年 Block. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInteger:_age forKey:@"age"];
    [aCoder encodeObject:_sex forKey:@"sex"];
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntegerForKey:@"age"];
        _sex = [aDecoder decodeObjectForKey:@"sex"];

    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    Person *person = [[self class] allocWithZone:zone];
    
    person.name = [self.name copyWithZone:zone];
    person.age = self.age;
    person.sex = [self.sex copyWithZone:zone];
    
    return person;
}

@end
