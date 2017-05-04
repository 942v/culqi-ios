//
//  CLQAntifraudDetails.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/4/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@interface CLQAntifraudDetails : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *countryCode;
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, copy, readonly) NSString *addressCity;
@property (nonatomic, copy, readonly) NSString *address;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *phone;

@end
