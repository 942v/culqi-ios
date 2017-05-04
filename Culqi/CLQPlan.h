//
//  CLQPlan.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/3/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

NS_ASSUME_NONNULL_BEGIN
@interface CLQPlan : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, copy, readonly) NSString *currencyCode;
@property (nonatomic, copy, readonly) NSString *interval;
@property (nonatomic, strong, readonly) NSNumber *intervalCount;
@property (nonatomic, strong, readonly) NSNumber *limit;// TODO: check with Culqi devs, docs say String, example says number
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) id subscriptions; // TODO: check with Culqi devs
@property (nonatomic, strong, readonly) NSNumber *trialDays;// TODO: check with Culqi devs, docs say String, example says number
@property (nonatomic, strong, readonly) NSNumber *totalSubscriptions;// TODO: check with Culqi devs
@property (nonatomic, strong, readonly) NSDictionary *metadata;

@end
NS_ASSUME_NONNULL_END
