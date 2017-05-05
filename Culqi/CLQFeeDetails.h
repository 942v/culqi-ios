//
//  CLQFeeDetails.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@class CLQFeeFixed, CLQFeeVariable;

@interface CLQFeeDetails : CLQBaseModelObject

@property (nonatomic, strong, readonly) CLQFeeFixed *fixedFee;
@property (nonatomic, strong, readonly) CLQFeeVariable *variableFee;

@end