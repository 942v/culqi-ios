//
//  CLQFeeFixed.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQFeeFixed.h"

@implementation CLQFeeFixed

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSNumber *amount = [data objectForKey:@"amount"];
    NSString *currencyCode = [data objectForKey:@"currency_code"];
    NSString *exchangeRate = [data objectForKey:@"exchange_rate"];
    NSString *exchangeRateCurrencyCode = [data objectForKey:@"exchange_rate_currency_code"];
    NSNumber *total = [data objectForKey:@"total"];
    
    return [[CLQFeeFixed alloc] initWithAmount:amount currencyCode:currencyCode exchangeRate:exchangeRate exchangeRateCurrencyCode:exchangeRateCurrencyCode total:total];
}

- (instancetype)initWithAmount:(NSNumber *)amount currencyCode:(NSString *)currencyCode exchangeRate:(NSString *)exchangeRate exchangeRateCurrencyCode:(NSString *)exchangeRateCurrencyCode total:(NSNumber *)total {
    
    self = [super init];
    if (self) {
        if ([amount isKindOfClass:[NSNumber class]])_amount = amount;
        if ([currencyCode isKindOfClass:[NSString class]])_currencyCode = currencyCode;
        if ([exchangeRate isKindOfClass:[NSString class]])_exchangeRate = exchangeRate;
        if ([exchangeRateCurrencyCode isKindOfClass:[NSString class]])_exchangeRateCurrencyCode = exchangeRateCurrencyCode;
        if ([total isKindOfClass:[NSNumber class]])_total = total;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _amount = [aDecoder decodeObjectOfClass:[self class] forKey:@"amount"];
        _currencyCode = [aDecoder decodeObjectOfClass:[self class] forKey:@"currencyCode"];
        _exchangeRate = [aDecoder decodeObjectOfClass:[self class] forKey:@"exchangeRate"];
        _exchangeRateCurrencyCode = [aDecoder decodeObjectOfClass:[self class] forKey:@"exchangeRateCurrencyCode"];
        _total = [aDecoder decodeObjectOfClass:[self class] forKey:@"total"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_amount forKey:@"amount"];
    [aCoder encodeObject:_currencyCode forKey:@"currencyCode"];
    [aCoder encodeObject:_exchangeRate forKey:@"exchangeRate"];
    [aCoder encodeObject:_exchangeRateCurrencyCode forKey:@"exchangeRateCurrencyCode"];
    [aCoder encodeObject:_total forKey:@"total"];
}

@end
