//
//  CLQFeeVariable.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

#import "CLQCurrencyCode.h"

NS_ASSUME_NONNULL_BEGIN
@interface CLQFeeVariable : CLQBaseModelObject

@property (nonatomic, assign, readonly) CLQCurrencyCodeType currencyCode;
@property (nonatomic, copy, readonly) NSNumber *commision;
@property (nonatomic, strong, readonly) NSNumber *total;

@end
NS_ASSUME_NONNULL_END
