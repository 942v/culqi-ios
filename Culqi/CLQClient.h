//
//  CLQClient.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@class CLQAntifraudDetails;

@interface CLQClient : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, strong, readonly) CLQAntifraudDetails *antifraudDetails;

@end
