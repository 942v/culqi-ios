//
//  CLQPlan.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/3/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQPlan.h"

@implementation CLQPlan

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *object = [data objectForKey:@"object"];
    NSString *identifier = [data objectForKey:@"id"];
    NSNumber *amount = [data objectForKey:@"amount"];
    NSNumber *creationDate = [data objectForKey:@"creation_date"];
    NSString *currencyCode = [data objectForKey:@"currency_code"];
    NSString *interval = [data objectForKey:@"interval"];
    NSNumber *intervalCount = [data objectForKey:@"interval_count"];
    NSNumber *limit = [data objectForKey:@"limit"];
    NSString *name = [data objectForKey:@"name"];
    id subscriptions = [data objectForKey:@"subscriptions"];
    NSNumber *trialDays = [data objectForKey:@"trial_days"];
    NSNumber *totalSubscriptions = [data objectForKey:@"total_subscriptions"];
    NSDictionary *metadata = [data objectForKey:@"metadata"];
    
    return [[CLQPlan alloc] initWithObject:object identifier:identifier amount:amount creationDate:creationDate currencyCode:currencyCode interval:interval intervalCount:intervalCount limit:limit name:name subscriptions:subscriptions trialDays:trialDays totalSubscriptions:totalSubscriptions metadata:metadata];
}

- (instancetype)initWithObject:(NSString *)object identifier:(NSString *)identifier amount:(NSNumber *)amount creationDate:(NSNumber *)creationDate currencyCode:(NSString *)currencyCode interval:(NSString *)interval intervalCount:(NSNumber *)intervalCount limit:(NSNumber *)limit name:(NSString *)name subscriptions:(id)subscriptions trialDays:(NSNumber *)trialDays totalSubscriptions:(NSNumber *)totalSubscriptions metadata:(NSDictionary *)metadata {
    
    self = [super init];
    if (self) {
        if ([object isKindOfClass:[NSString class]])_object = object;
        if ([identifier isKindOfClass:[NSString class]])_identifier = identifier;
        if ([amount isKindOfClass:[NSNumber class]])_amount = amount;
        if ([creationDate isKindOfClass:[NSNumber class]])_creationDate = [NSDate dateWithTimeIntervalSince1970:creationDate.doubleValue];
        if ([currencyCode isKindOfClass:[NSString class]])_currencyCode = [CLQCurrencyCode getCurrencyCodeTypeEnumForKey:currencyCode];
        if ([interval isKindOfClass:[NSString class]])_interval = [CLQPlan getPlanIntervalEnumForKey:interval];
        if ([intervalCount isKindOfClass:[NSNumber class]])_intervalCount = intervalCount;
        if ([limit isKindOfClass:[NSNumber class]])_limit = limit;
        if ([name isKindOfClass:[NSString class]])_name = name;
        _subscriptions = subscriptions;
        if ([trialDays isKindOfClass:[NSNumber class]])_trialDays = trialDays;
        if ([totalSubscriptions isKindOfClass:[NSNumber class]])_totalSubscriptions = totalSubscriptions;
        if ([metadata isKindOfClass:[NSDictionary class]])_metadata = metadata;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _object = [aDecoder decodeObjectOfClass:[self class] forKey:@"object"];
        _identifier = [aDecoder decodeObjectOfClass:[self class] forKey:@"identifier"];
        _amount = [aDecoder decodeObjectOfClass:[self class] forKey:@"amount"];
        _currencyCode = [CLQCurrencyCode getCurrencyCodeTypeEnumForKey:[aDecoder decodeObjectOfClass:[self class] forKey:@"currencyCode"]];
        _creationDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"creationDate"];
        _interval = [CLQPlan getPlanIntervalEnumForKey:[aDecoder decodeObjectOfClass:[self class] forKey:@"interval"]];
        _intervalCount = [aDecoder decodeObjectOfClass:[self class] forKey:@"intervalCount"];
        _limit = [aDecoder decodeObjectOfClass:[self class] forKey:@"limit"];
        _name = [aDecoder decodeObjectOfClass:[self class] forKey:@"name"];
        _subscriptions = [aDecoder decodeObjectOfClass:[self class] forKey:@"subscriptions"];
        _trialDays = [aDecoder decodeObjectOfClass:[self class] forKey:@"trialDays"];
        _totalSubscriptions = [aDecoder decodeObjectOfClass:[self class] forKey:@"totalSubscriptions"];
        _metadata = [aDecoder decodeObjectOfClass:[self class] forKey:@"metadata"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_object forKey:@"object"];
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_amount forKey:@"amount"];
    [aCoder encodeObject:[CLQCurrencyCode getCurrencyCodeTypeKeyForEnum:_currencyCode] forKey:@"currencyCode"];
    [aCoder encodeObject:_creationDate forKey:@"creationDate"];
    [aCoder encodeObject:[CLQPlan getPlanIntervalKeyForEnum:_interval] forKey:@"interval"];
    [aCoder encodeObject:_intervalCount forKey:@"intervalCount"];
    [aCoder encodeObject:_limit forKey:@"limit"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_subscriptions forKey:@"subscriptions"];
    [aCoder encodeObject:_trialDays forKey:@"trialDays"];
    [aCoder encodeObject:_totalSubscriptions forKey:@"totalSubscriptions"];
    [aCoder encodeObject:_metadata forKey:@"metadata"];
}

@end

@implementation CLQPlan (Helpers)

+ (CLQPlanInterval)getPlanIntervalEnumForKey:(NSString *)planInterval {
    
    if ([planInterval isEqualToString:@"dias"]) {
        return CLQPlanIntervalDaily;
    }else if ([planInterval isEqualToString:@"semanas"]) {
        return CLQPlanIntervalWeekly;
    }else if ([planInterval isEqualToString:@"meses"]) {
        return CLQPlanIntervalMonthly;
    }else if ([planInterval isEqualToString:@"años"]) {
        return CLQPlanIntervalYearly;
    }
    
    return CLQPlanIntervalUnknown;
}

+ (NSString *)getPlanIntervalKeyForEnum:(CLQPlanInterval)planInterval {
    
    switch (planInterval) {
        case CLQPlanIntervalDaily:
            return @"dias";
            break;
        case CLQPlanIntervalWeekly:
            return @"semanas";
            break;
        case CLQPlanIntervalMonthly:
            return @"meses";
            break;
        case CLQPlanIntervalYearly:
            return @"años";
            break;
        default:
            return NULL;
            break;
    }
}

@end
