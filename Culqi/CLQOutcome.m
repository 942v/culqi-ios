//
//  CLQOutcome.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQOutcome.h"

@implementation CLQOutcome

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *type = [data objectForKey:@"type"];
    NSString *code = [data objectForKey:@"code"];
    NSString *declineCode = [data objectForKey:@"decline_code"];
    NSString *merchantMessage = [data objectForKey:@"merchant_message"];
    NSString *userMessage = [data objectForKey:@"user_message"];
    
    return [[CLQOutcome alloc] initWithType:type code:code declineCode:declineCode merchantMessage:merchantMessage userMessage:userMessage];
}

- (instancetype)initWithType:(NSString *)type code:(NSString *)code declineCode:(NSString *)declineCode merchantMessage:(NSString *)merchantMessage userMessage:(NSString *)userMessage {
    
    self = [super init];
    if (self) {
        if ([type isKindOfClass:[NSString class]])_type = type;
        if ([code isKindOfClass:[NSString class]])_code = [CLQOutcome getOutcomeCodeEnumForKey:code];
        if ([declineCode isKindOfClass:[NSString class]])_declineCode = declineCode;
        if ([merchantMessage isKindOfClass:[NSString class]])_merchantMessage = merchantMessage;
        if ([userMessage isKindOfClass:[NSString class]])_userMessage = userMessage;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _type = [aDecoder decodeObjectOfClass:[self class] forKey:@"type"];
        _code = [CLQOutcome getOutcomeCodeEnumForKey:[aDecoder decodeObjectOfClass:[self class] forKey:@"code"]];
        _declineCode = [aDecoder decodeObjectOfClass:[self class] forKey:@"declineCode"];
        _merchantMessage = [aDecoder decodeObjectOfClass:[self class] forKey:@"merchantMessage"];
        _userMessage = [aDecoder decodeObjectOfClass:[self class] forKey:@"userMessage"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:[CLQOutcome getOutcomeCodeKeyForEnum:_code] forKey:@"code"];
    [aCoder encodeObject:_declineCode forKey:@"declineCode"];
    [aCoder encodeObject:_merchantMessage forKey:@"merchantMessage"];
    [aCoder encodeObject:_userMessage forKey:@"userMessage"];
}

@end

@implementation CLQOutcome (Helpers)

+ (CLQOutcomeCode)getOutcomeCodeEnumForKey:(NSString *)outcomeCode {
    
    if ([outcomeCode isEqualToString:@"succesfull_charge"]) {
        return CLQOutcomeCodeSuccesfullCharge;
    }else if ([outcomeCode isEqualToString:@"card_declined"]) {
        return CLQOutcomeCodeCardDeclined;
    }
    
    return CLQOutcomeCodeUnkown;
}

+ (NSString *)getOutcomeCodeKeyForEnum:(CLQOutcomeCode)outcomeCode {
    
    switch (outcomeCode) {
        case CLQOutcomeCodeSuccesfullCharge:
            return @"succesfull_charge";
            break;
        case CLQOutcomeCodeCardDeclined:
            return @"card_declined";
            break;
        default:
            return NULL;
            break;
    }
}

@end
