//
//  CLQIssuerIdentificationNumber.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@class CLQCardIssuer;

@interface CLQIssuerIdentificationNumber : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *bin;
@property (nonatomic, copy, readonly) NSString *cardBrand;
@property (nonatomic, copy, readonly) NSString *cardType;
@property (nonatomic, copy, readonly) NSString *cardCategory;
@property (nonatomic, copy, readonly) CLQCardIssuer *issuer;
@property (nonatomic, strong, readonly) NSArray <NSNumber *> *installmentsAllowed;

@end
