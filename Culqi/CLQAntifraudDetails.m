//
//  CLQAntifraudDetails.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/4/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQAntifraudDetails.h"

@implementation CLQAntifraudDetails

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *object = [data objectForKey:@"object"];
    NSString *countryCode = [data objectForKey:@"country_code"];
    NSString *firstName = [data objectForKey:@"first_name"];
    NSString *lastName = [data objectForKey:@"last_name"];
    NSString *addressCity = [data objectForKey:@"address_city"];
    NSString *address = [data objectForKey:@"address"];
    NSString *email = [data objectForKey:@"email"];
    NSString *phone = [data objectForKey:@"phone"];
    
    return [[CLQAntifraudDetails alloc] initWithObject:object countryCode:countryCode firstName:firstName lastName:lastName addressCity:addressCity address:address email:email phone:phone];
}

- (instancetype)initWithObject:(NSString *)object countryCode:(NSString *)countryCode firstName:(NSString *)firstName lastName:(NSString *)lastName addressCity:(NSString *)addressCity address:(NSString *)address email:(NSString *)email phone:(NSString *)phone {
    
    self = [super init];
    if (self) {
        if ([object isKindOfClass:[NSString class]])_object = object;
        if ([countryCode isKindOfClass:[NSString class]])_countryCode = countryCode;
        if ([firstName isKindOfClass:[NSString class]])_firstName = firstName;
        if ([lastName isKindOfClass:[NSString class]])_lastName = lastName;
        if ([addressCity isKindOfClass:[NSString class]])_addressCity = addressCity;
        if ([address isKindOfClass:[NSString class]])_address = address;
        if ([email isKindOfClass:[NSString class]])_email = email;
        if ([phone isKindOfClass:[NSString class]])_phone = phone;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _object = [aDecoder decodeObjectOfClass:[self class] forKey:@"object"];
        _countryCode = [aDecoder decodeObjectOfClass:[self class] forKey:@"_countryCode"];
        _firstName = [aDecoder decodeObjectOfClass:[self class] forKey:@"_firstName"];
        _email = [aDecoder decodeObjectOfClass:[self class] forKey:@"_lastName"];
        _addressCity = [aDecoder decodeObjectOfClass:[self class] forKey:@"_addressCity"];
        _address = [aDecoder decodeObjectOfClass:[self class] forKey:@"_address"];
        _email = [aDecoder decodeObjectOfClass:[self class] forKey:@"_email"];
        _phone = [aDecoder decodeObjectOfClass:[self class] forKey:@"_phone"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_object forKey:@"object"];
    [aCoder encodeObject:_countryCode forKey:@"_countryCode"];
    [aCoder encodeObject:_firstName forKey:@"_firstName"];
    [aCoder encodeObject:_lastName forKey:@"_lastName"];
    [aCoder encodeObject:_addressCity forKey:@"_addressCity"];
    [aCoder encodeObject:_address forKey:@"_address"];
    [aCoder encodeObject:_email forKey:@"_email"];
    [aCoder encodeObject:_phone forKey:@"_phone"];
}

@end
