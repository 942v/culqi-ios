//
//  CLQPlan.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/3/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

#import "CLQCurrencyCode.h"

typedef enum : NSUInteger {
    CLQPlanIntervalUnknown,
    CLQPlanIntervalDaily,
    CLQPlanIntervalWeekly,
    CLQPlanIntervalMonthly,
    CLQPlanIntervalYearly
} CLQPlanInterval;

NS_ASSUME_NONNULL_BEGIN
@interface CLQPlan : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, assign, readonly) CLQCurrencyCodeType currencyCode;
@property (nonatomic, assign, readonly) CLQPlanInterval interval;
@property (nonatomic, strong, readonly) NSNumber *intervalCount;
@property (nonatomic, strong, readonly) NSNumber *limit;// TODO: check with Culqi devs, docs say String, example says number
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) id subscriptions; // TODO: check with Culqi devs
@property (nonatomic, strong, readonly) NSNumber *trialDays;// TODO: check with Culqi devs, docs say String, example says number
@property (nonatomic, strong, readonly) NSNumber *totalSubscriptions;// TODO: check with Culqi devs
@property (nonatomic, strong, readonly) NSDictionary *metadata;

@end

@interface CLQPlan (Helpers)

+ (NSString *)getPlanIntervalKeyForEnum:(CLQPlanInterval)planInterval;
+ (CLQPlanInterval)getPlanIntervalEnumForKey:(NSString *)planInterval;

@end
NS_ASSUME_NONNULL_END
