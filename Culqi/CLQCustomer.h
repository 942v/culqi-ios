//
//  CLQCustomer.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/4/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@class CLQAntifraudDetails;

@interface CLQCustomer : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, strong, readonly) CLQAntifraudDetails *antifraudDetails;
@property (nonatomic, strong, readonly) NSDictionary *metadata;

@end
