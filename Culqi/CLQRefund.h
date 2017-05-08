//
//  CLQRefund.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/8/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

NS_ASSUME_NONNULL_BEGIN
@interface CLQRefund : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *chargeIdentifier;
@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, copy, readonly) NSString *reason;
@property (nonatomic, strong, readonly) NSDictionary *metadata;

@end
NS_ASSUME_NONNULL_END
