//
//  CLQCurrencyCode.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/8/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CLQCurrencyCodeTypeUnknown,
    CLQCurrencyCodeTypePEN,
    CLQCurrencyCodeTypeUSD
} CLQCurrencyCodeType;

@interface CLQCurrencyCode : NSObject

+ (NSString *)getCurrencyCodeTypeKeyForEnum:(CLQCurrencyCodeType)currencyCodeType;
+ (CLQCurrencyCodeType)getCurrencyCodeTypeEnumForKey:(NSString *)currencyCodeType;

@end
