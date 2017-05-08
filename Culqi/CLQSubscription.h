//
//  CLQSubscription.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/7/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

typedef enum : NSUInteger {
    CLQSubscriptionStatusUnknown,
    CLQSubscriptionStatusActive,
    CLQSubscriptionStatusCanceled,
    CLQSubscriptionStatusFinished,
} CLQSubscriptionStatus;

@class CLQCharge, CLQPlan, CLQCard;

NS_ASSUME_NONNULL_BEGIN
@interface CLQSubscription : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, assign, readonly) CLQSubscriptionStatus status;
@property (nonatomic, strong, readonly) NSNumber *currentPeriod;
@property (nonatomic, strong, readonly) NSNumber *totalPeriods;
@property (nonatomic, strong, readonly) NSDate *currentPeriodStartDate;
@property (nonatomic, strong, readonly) NSDate *currentPeriodEndDate;
@property (nonatomic, assign, readonly, getter=shouldCancelAtPeriodEnd) BOOL cancelAtPeriodEnd;
@property (nonatomic, strong, readonly) NSDate *canceledAtDate;
@property (nonatomic, strong, readonly) NSDate *endedAtDate;
@property (nonatomic, strong, readonly) NSDate *nextBillingDate;
@property (nonatomic, strong, readonly) NSDate *trialStartDate;
@property (nonatomic, strong, readonly) NSDate *trialEndDate;
@property (nonatomic, strong, readonly) NSArray <CLQCharge *> *charges;
@property (nonatomic, strong, readonly) CLQPlan *plan;
@property (nonatomic, strong, readonly) CLQCard *card;
@property (nonatomic, strong, readonly) NSDictionary *metadata;

@end

@interface CLQSubscription (Helpers)

+ (NSString *)getSubscriptionStatusKeyForEnum:(CLQSubscriptionStatus)subscriptionStatus;
+ (CLQSubscriptionStatus)getSubscriptionStatusEnumForKey:(NSString *)subscriptionStatus;

@end
NS_ASSUME_NONNULL_END
