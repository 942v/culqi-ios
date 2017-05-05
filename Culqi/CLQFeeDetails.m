//
//  CLQFeeDetails.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQFeeDetails.h"

#import "CLQFeeFixed.h"
#import "CLQFeeVariable.h"

@implementation CLQFeeDetails

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSDictionary *fixedFeeData = [data objectForKey:@"fixed_fee"];
    NSDictionary *variableFeeData = [data objectForKey:@"variable_fee"];
    
    return [[CLQFeeDetails alloc] initWithFixedFeeData:fixedFeeData variableFeeData:variableFeeData];
}

- (instancetype)initWithFixedFeeData:(NSDictionary *)fixedFeeData variableFeeData:(NSDictionary *)variableFeeData {
    
    self = [super init];
    if (self) {
        if ([fixedFeeData isKindOfClass:[NSDictionary class]])_fixedFee = [CLQFeeFixed newWithData:fixedFeeData];
        if ([variableFeeData isKindOfClass:[NSDictionary class]])_variableFee = [CLQFeeVariable newWithData:variableFeeData];
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _fixedFee = [aDecoder decodeObjectOfClass:[self class] forKey:@"fixedFee"];
        _variableFee = [aDecoder decodeObjectOfClass:[self class] forKey:@"variableFee"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_fixedFee forKey:@"fixedFee"];
    [aCoder encodeObject:_variableFee forKey:@"variableFee"];
}

@end
