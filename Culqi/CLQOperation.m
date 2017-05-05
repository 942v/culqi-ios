//
//  CLQOperation.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQOperation.h"

@implementation CLQOperation

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *type = [data objectForKey:@"type"];
    NSString *identifier = [data objectForKey:@"operation_id"];
    NSNumber *creationDate = [data objectForKey:@"creation_date"];
    
    return [[CLQOperation alloc] initWithType:type identifier:identifier creationDate:creationDate];
}

- (instancetype)initWithType:(NSString *)type identifier:(NSString *)identifier creationDate:(NSNumber *)creationDate {
    
    self = [super init];
    if (self) {
        if ([type isKindOfClass:[NSString class]])_type = type;
        if ([identifier isKindOfClass:[NSString class]])_identifier = identifier;
        if ([creationDate isKindOfClass:[NSNumber class]])_creationDate = [NSDate dateWithTimeIntervalSince1970:creationDate.doubleValue];
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _type = [aDecoder decodeObjectOfClass:[self class] forKey:@"type"];
        _identifier = [aDecoder decodeObjectOfClass:[self class] forKey:@"identifier"];
        _creationDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"creationDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_creationDate forKey:@"creationDate"];
}

@end
