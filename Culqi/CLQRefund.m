//
//  CLQRefund.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/8/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQRefund.h"

@implementation CLQRefund

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *object = [data objectForKey:@"object"];
    NSString *identifier = [data objectForKey:@"id"];
    NSString *chargeIdentifier = [data objectForKey:@"charge_id"];
    NSNumber *creationDate = [data objectForKey:@"creation_date"];
    NSNumber *amount = [data objectForKey:@"amount"];
    NSString *reason = [data objectForKey:@"reason"];
    NSDictionary *metadata = [data objectForKey:@"metadata"];
    
    return [[CLQRefund alloc] initWithObject:object identifier:identifier chargeIdentifier:chargeIdentifier creationDate:creationDate amount:amount reason:reason metadata:metadata];
}

- (instancetype)initWithObject:(NSString *)object identifier:(NSString *)identifier chargeIdentifier:(NSString *)chargeIdentifier creationDate:(NSNumber *)creationDate amount:(NSNumber *)amount reason:(NSString *)reason metadata:(NSDictionary *)metadata {
    
    self = [super init];
    if (self) {
        if ([object isKindOfClass:[NSString class]])_object = object;
        if ([identifier isKindOfClass:[NSString class]])_identifier = identifier;
        if ([chargeIdentifier isKindOfClass:[NSString class]])_chargeIdentifier = chargeIdentifier;
        if ([creationDate isKindOfClass:[NSNumber class]])_creationDate = [NSDate dateWithTimeIntervalSince1970:creationDate.doubleValue];
        if ([amount isKindOfClass:[NSNumber class]])_amount = amount;
        if ([reason isKindOfClass:[NSString class]])_reason = reason;
        if ([metadata isKindOfClass:[NSDictionary class]])_metadata = metadata;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _object = [aDecoder decodeObjectOfClass:[self class] forKey:@"object"];
        _identifier = [aDecoder decodeObjectOfClass:[self class] forKey:@"identifier"];
        _chargeIdentifier = [aDecoder decodeObjectOfClass:[self class] forKey:@"chargeIdentifier"];
        _creationDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"creationDate"];
        _amount = [aDecoder decodeObjectOfClass:[self class] forKey:@"amount"];
        _reason = [aDecoder decodeObjectOfClass:[self class] forKey:@"reason"];
        _metadata = [aDecoder decodeObjectOfClass:[self class] forKey:@"metadata"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_object forKey:@"object"];
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_chargeIdentifier forKey:@"chargeIdentifier"];
    [aCoder encodeObject:_creationDate forKey:@"creationDate"];
    [aCoder encodeObject:_amount forKey:@"amount"];
    [aCoder encodeObject:_reason forKey:@"reason"];
    [aCoder encodeObject:_metadata forKey:@"metadata"];
}

@end
