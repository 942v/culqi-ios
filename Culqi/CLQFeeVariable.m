//
//  CLQFeeVariable.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQFeeVariable.h"

@implementation CLQFeeVariable

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *currencyCode = [data objectForKey:@"currency_code"];
    NSNumber *commision = [data objectForKey:@"commision"];
    NSNumber *total = [data objectForKey:@"total"];
    
    return [[CLQFeeVariable alloc] initWithCurrencyCode:currencyCode commision:commision total:total];
}

- (instancetype)initWithCurrencyCode:(NSString *)currencyCode commision:(NSNumber *)commision total:(NSNumber *)total {
    
    self = [super init];
    if (self) {
        if ([currencyCode isKindOfClass:[NSString class]])_currencyCode = [CLQCurrencyCode getCurrencyCodeTypeEnumForKey:currencyCode];
        if ([commision isKindOfClass:[NSString class]])_commision = commision;
        if ([total isKindOfClass:[NSNumber class]])_total = total;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _currencyCode = [CLQCurrencyCode getCurrencyCodeTypeEnumForKey:[aDecoder decodeObjectOfClass:[self class] forKey:@"currencyCode"]];
        _commision = [aDecoder decodeObjectOfClass:[self class] forKey:@"commision"];
        _total = [aDecoder decodeObjectOfClass:[self class] forKey:@"total"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[CLQCurrencyCode getCurrencyCodeTypeKeyForEnum:_currencyCode] forKey:@"currencyCode"];
    [aCoder encodeObject:_commision forKey:@"commision"];
    [aCoder encodeObject:_total forKey:@"total"];
}

@end
