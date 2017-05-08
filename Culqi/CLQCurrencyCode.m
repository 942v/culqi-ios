//
//  CLQCurrencyCode.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/8/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQCurrencyCode.h"

@implementation CLQCurrencyCode

+ (CLQCurrencyCodeType)getCurrencyCodeTypeEnumForKey:(NSString *)currencyCodeType {
    
    if ([currencyCodeType isEqualToString:@"PEN"]) {
        return CLQCurrencyCodeTypePEN;
    }else if ([currencyCodeType isEqualToString:@"USD"]) {
        return CLQCurrencyCodeTypeUSD;
    }
    
    return CLQCurrencyCodeTypeUnknown;
}

+ (NSString *)getCurrencyCodeTypeKeyForEnum:(CLQCurrencyCodeType)currencyCodeType {
    
    switch (currencyCodeType) {
        case CLQCurrencyCodeTypePEN:
            return @"PEN";
            break;
        case CLQCurrencyCodeTypeUSD:
            return @"USD";
            break;
        default:
            return NULL;
            break;
    }
}

@end
