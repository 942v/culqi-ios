//
//  CLQCustomer.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/4/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQCustomer.h"

#import "CLQAntifraudDetails.h"

@implementation CLQCustomer

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *object = [data objectForKey:@"object"];
    NSString *identifier = [data objectForKey:@"id"];
    NSNumber *creationDate = [data objectForKey:@"creation_date"];
    NSString *email = [data objectForKey:@"email"];
    NSDictionary *antifraudDetailsData = [data objectForKey:@"antifraud_details"];
    NSDictionary *metadata = [data objectForKey:@"metadata"];
    
    return [[CLQCustomer alloc] initWithObject:object identifier:identifier creationDate:creationDate email:email antifraudDetailsData:antifraudDetailsData metadata:metadata];
}

- (instancetype)initWithObject:(NSString *)object identifier:(NSString *)identifier creationDate:(NSNumber *)creationDate email:(NSString *)email antifraudDetailsData:(NSDictionary *)antifraudDetailsData metadata:(NSDictionary *)metadata {
    
    self = [super init];
    if (self) {
        if ([object isKindOfClass:[NSString class]])_object = object;
        if ([identifier isKindOfClass:[NSString class]])_identifier = identifier;
        if ([creationDate isKindOfClass:[NSNumber class]])_creationDate = [NSDate dateWithTimeIntervalSince1970:creationDate.doubleValue];
        if ([email isKindOfClass:[NSString class]])_email = email;
        if ([antifraudDetailsData isKindOfClass:[NSDictionary class]])_antifraudDetails = [CLQAntifraudDetails newWithData:antifraudDetailsData];
        if ([metadata isKindOfClass:[NSDictionary class]]) _metadata = metadata;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _object = [aDecoder decodeObjectOfClass:[self class] forKey:@"object"];
        _identifier = [aDecoder decodeObjectOfClass:[self class] forKey:@"identifier"];
        _creationDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"creationDate"];
        _email = [aDecoder decodeObjectOfClass:[self class] forKey:@"email"];
        _antifraudDetails = [aDecoder decodeObjectOfClass:[self class] forKey:@"antifraudDetails"];
        _metadata = [aDecoder decodeObjectOfClass:[self class] forKey:@"metadata"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_object forKey:@"object"];
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_creationDate forKey:@"creationDate"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_antifraudDetails forKey:@"antifraudDetails"];
    [aCoder encodeObject:_metadata forKey:@"metadata"];
}

@end
