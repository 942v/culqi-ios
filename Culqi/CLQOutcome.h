//
//  CLQOutcome.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

typedef enum : NSUInteger {
    CLQOutcomeCodeUnkown,
    CLQOutcomeCodeSuccesfullCharge,
    CLQOutcomeCodeCardDeclined
} CLQOutcomeCode;

NS_ASSUME_NONNULL_BEGIN
@interface CLQOutcome : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, assign, readonly) CLQOutcomeCode code;
@property (nonatomic, copy, readonly) NSString *declineCode;
@property (nonatomic, copy, readonly) NSString *merchantMessage;
@property (nonatomic, copy, readonly) NSString *userMessage;

@end

@interface CLQOutcome (Helpers)

+ (NSString *)getOutcomeCodeKeyForEnum:(CLQOutcomeCode)outcomeCode;
+ (CLQOutcomeCode)getOutcomeCodeEnumForKey:(NSString *)outcomeCode;

@end
NS_ASSUME_NONNULL_END
