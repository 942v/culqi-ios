//
//  CLQSubscription.m
//  Pods
//
//  Created by Guillermo Sáenz on 5/7/17.
//
//

#import "CLQSubscription.h"

#import "CLQPlan.h"
#import "CLQCard.h"
#import "CLQCharge.h"

@implementation CLQSubscription

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *object = [data objectForKey:@"object"];
    NSString *identifier = [data objectForKey:@"id"];
    NSNumber *creationDate = [data objectForKey:@"creation_date"];
    NSString *status = [data objectForKey:@"status"];
    NSNumber *currentPeriod = [data objectForKey:@"current_period"];
    NSNumber *totalPeriods = [data objectForKey:@"total_periods"];
    NSNumber *currentPeriodStartDate = [data objectForKey:@"current_period_start"];
    NSNumber *currentPeriodEndDate = [data objectForKey:@"current_period_end"];
    NSNumber *cancelAtPeriodEnd = [data objectForKey:@"cancel_at_period_end"];
    NSNumber *canceledAtDate = [data objectForKey:@"canceled_at"];
    NSNumber *endedAtDate = [data objectForKey:@"ended_at"];
    NSNumber *nextBillingDate = [data objectForKey:@"next_billing_date"];
    NSNumber *trialStartDate = [data objectForKey:@"trial_start"];
    NSNumber *trialEndDate = [data objectForKey:@"trial_end"];
    NSArray <NSDictionary *> *chargesData = [data objectForKey:@"charges"];
    NSDictionary *planData = [data objectForKey:@"plan"];
    NSDictionary *cardData = [data objectForKey:@"card"];
    NSDictionary *metadata = [data objectForKey:@"metadata"];
    
    return [[CLQSubscription alloc] initWithObject:object identifier:identifier creationDate:creationDate status:status currentPeriod:currentPeriod totalPeriods:totalPeriods currentPeriodStartDate:currentPeriodStartDate currentPeriodEndDate:currentPeriodEndDate cancelAtPeriodEnd:cancelAtPeriodEnd canceledAtDate:canceledAtDate endedAtDate:endedAtDate nextBillingDate:nextBillingDate trialStartDate:trialStartDate trialEndDate:trialEndDate chargesData:chargesData planData:planData cardData:cardData metadata:metadata];
}

- (instancetype)initWithObject:(NSString *)object
                    identifier:(NSString *)identifier
                  creationDate:(NSNumber *)creationDate
                        status:(NSString *)status
                 currentPeriod:(NSNumber *)currentPeriod
                  totalPeriods:(NSNumber *)totalPeriods
        currentPeriodStartDate:(NSNumber *)currentPeriodStartDate
          currentPeriodEndDate:(NSNumber *)currentPeriodEndDate
             cancelAtPeriodEnd:(NSNumber *)cancelAtPeriodEnd
                canceledAtDate:(NSNumber *)canceledAtDate
                   endedAtDate:(NSNumber *)endedAtDate
               nextBillingDate:(NSNumber *)nextBillingDate
                trialStartDate:(NSNumber *)trialStartDate
                  trialEndDate:(NSNumber *)trialEndDate
                   chargesData:(NSArray <NSDictionary *> *)chargesData
                      planData:(NSDictionary *)planData
                      cardData:(NSDictionary *)cardData
                      metadata:(NSDictionary *)metadata {
    
    self = [super init];
    if (self) {
        if ([object isKindOfClass:[NSString class]])_object = object;
        if ([identifier isKindOfClass:[NSString class]])_identifier = identifier;
        if ([creationDate isKindOfClass:[NSNumber class]])_creationDate = [NSDate dateWithTimeIntervalSince1970:creationDate.doubleValue];
        if ([status isKindOfClass:[NSString class]])_status = status;
        if ([currentPeriod isKindOfClass:[NSNumber class]])_currentPeriod = currentPeriod;
        
        if ([totalPeriods isKindOfClass:[NSNumber class]])_totalPeriods = totalPeriods;
        if ([currentPeriodStartDate isKindOfClass:[NSNumber class]])_currentPeriodStartDate = [NSDate dateWithTimeIntervalSince1970:currentPeriodStartDate.doubleValue];
        if ([currentPeriodEndDate isKindOfClass:[NSNumber class]])_currentPeriodEndDate = [NSDate dateWithTimeIntervalSince1970:currentPeriodEndDate.doubleValue];
        if ([cancelAtPeriodEnd isKindOfClass:[NSNumber class]])_cancelAtPeriodEnd = cancelAtPeriodEnd.boolValue;
        if ([canceledAtDate isKindOfClass:[NSNumber class]])_canceledAtDate = [NSDate dateWithTimeIntervalSince1970:canceledAtDate.doubleValue];
        
        if ([endedAtDate isKindOfClass:[NSNumber class]])_endedAtDate = [NSDate dateWithTimeIntervalSince1970:endedAtDate.doubleValue];
        if ([nextBillingDate isKindOfClass:[NSNumber class]])_nextBillingDate = [NSDate dateWithTimeIntervalSince1970:nextBillingDate.doubleValue];
        if ([trialStartDate isKindOfClass:[NSNumber class]])_trialStartDate = [NSDate dateWithTimeIntervalSince1970:trialStartDate.doubleValue];
        if ([trialEndDate isKindOfClass:[NSNumber class]])_trialEndDate = [NSDate dateWithTimeIntervalSince1970:trialEndDate.doubleValue];
        if ([chargesData isKindOfClass:[NSArray class]]) {
            NSMutableArray <CLQCharge *> *charges = [NSMutableArray array];
            for (NSDictionary *chargeData in chargesData) {
                CLQCharge *charge = [CLQCharge newWithData:chargeData];
                if (charge)[charges addObject:charge];
            }
            _charges = charges.copy;
        }
        
        if ([planData isKindOfClass:[NSDictionary class]])_plan = [CLQPlan newWithData:planData];
        if ([cardData isKindOfClass:[NSDictionary class]])_card = [CLQCard newWithData:cardData];
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
        _creationDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"creationDate"];
        _status = [aDecoder decodeObjectOfClass:[self class] forKey:@"status"];
        _currentPeriod = [aDecoder decodeObjectOfClass:[self class] forKey:@"currentPeriod"];
        
        _totalPeriods = [aDecoder decodeObjectOfClass:[self class] forKey:@"totalPeriods"];
        _currentPeriodStartDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"currentPeriodStartDate"];
        _currentPeriodEndDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"currentPeriodEndDate"];
        _cancelAtPeriodEnd = [[aDecoder decodeObjectOfClass:[self class] forKey:@"cancelAtPeriodEnd"] boolValue];
        _canceledAtDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"canceledAtDate"];
        
        _endedAtDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"endedAtDate"];
        _nextBillingDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"nextBillingDate"];
        _trialStartDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"trialStartDate"];
        _trialEndDate = [aDecoder decodeObjectOfClass:[self class] forKey:@"trialEndDate"];
        _charges = [aDecoder decodeObjectOfClass:[self class] forKey:@"charges"];
        
        _plan = [aDecoder decodeObjectOfClass:[self class] forKey:@"plan"];
        _card = [aDecoder decodeObjectOfClass:[self class] forKey:@"card"];
        _metadata = [aDecoder decodeObjectOfClass:[self class] forKey:@"metadata"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_object forKey:@"object"];
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_creationDate forKey:@"creationDate"];
    [aCoder encodeObject:_status forKey:@"status"];
    [aCoder encodeObject:_currentPeriod forKey:@"currentPeriod"];
    
    [aCoder encodeObject:_totalPeriods forKey:@"totalPeriods"];
    [aCoder encodeObject:_currentPeriodStartDate forKey:@"currentPeriodStartDate"];
    [aCoder encodeObject:_currentPeriodEndDate forKey:@"currentPeriodEndDate"];
    [aCoder encodeObject:@(_cancelAtPeriodEnd) forKey:@"cancelAtPeriodEnd"];
    [aCoder encodeObject:_canceledAtDate forKey:@"canceledAtDate"];
    
    [aCoder encodeObject:_endedAtDate forKey:@"endedAtDate"];
    [aCoder encodeObject:_nextBillingDate forKey:@"nextBillingDate"];
    [aCoder encodeObject:_trialStartDate forKey:@"trialStartDate"];
    [aCoder encodeObject:_trialEndDate forKey:@"trialEndDate"];
    [aCoder encodeObject:_charges forKey:@"charges"];
    
    [aCoder encodeObject:_plan forKey:@"plan"];
    [aCoder encodeObject:_card forKey:@"card"];
    [aCoder encodeObject:_metadata forKey:@"metadata"];
}

@end

@implementation CLQSubscription (Helpers)

+ (CLQSubscriptionStatus)getSubscriptionStatusEnumForKey:(NSString *)subscriptionStatus {
    
    if ([subscriptionStatus isEqualToString:@"active"]) {
        return CLQSubscriptionStatusActive;
    }else if ([subscriptionStatus isEqualToString:@"canceled"]) {
        return CLQSubscriptionStatusCanceled;
    }else if ([subscriptionStatus isEqualToString:@"finished"]) {
        return CLQSubscriptionStatusFinished;
    }
    
    return CLQSubscriptionStatusUnknown;
}

+ (NSString *)getSubscriptionStatusKeyForEnum:(CLQSubscriptionStatus)subscriptionStatus {
    
    switch (subscriptionStatus) {
        case CLQSubscriptionStatusActive:
            return @"active";
            break;
        case CLQSubscriptionStatusCanceled:
            return @"canceled";
            break;
        case CLQSubscriptionStatusFinished:
            return @"finished";
            break;
        default:
            return NULL;
            break;
    }
}

@end
