//
//  CLQFeeFixed.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@interface CLQFeeFixed : CLQBaseModelObject

@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, copy, readonly) NSString *currencyCode;
@property (nonatomic, copy, readonly) NSString *exchangeRate;
@property (nonatomic, copy, readonly) NSString *exchangeRateCurrencyCode;
@property (nonatomic, strong, readonly) NSNumber *total;

@end
