//
//  CLQCharge.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

#import "CLQCurrencyCode.h"

@class CLQToken, CLQCard, CLQClient, CLQOutcome, CLQAntifraudDetails, CLQFeeDetails, CLQOperation;

NS_ASSUME_NONNULL_BEGIN
@interface CLQCharge : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, strong, readonly) NSNumber *amountRefunded;
@property (nonatomic, strong, readonly) NSNumber *currentAmount;
@property (nonatomic, strong, readonly) NSNumber *installments;
@property (nonatomic, strong, readonly) NSNumber *installmentsAmount;
@property (nonatomic, assign, readonly) CLQCurrencyCodeType currencyCode;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *descriptionText;
@property (nonatomic, strong, readonly) CLQToken *token;
@property (nonatomic, strong, readonly) CLQCard *card;
@property (nonatomic, strong, readonly) CLQOutcome *outcome;
@property (nonatomic, strong, readonly) NSNumber *fraudScore;
@property (nonatomic, strong, readonly) CLQAntifraudDetails *antifraudDetails;
@property (nonatomic, strong, readonly) CLQClient *client;
@property (nonatomic, assign, readonly, getter=isDisputed) BOOL disputed;
@property (nonatomic, assign, readonly, getter=isCaptured) BOOL captured;
@property (nonatomic, copy, readonly) NSString *referenceCode;
@property (nonatomic, assign, readonly, getter=isDuplicated) BOOL duplicated;
@property (nonatomic, strong, readonly) NSDictionary *metadata;
@property (nonatomic, strong, readonly) NSNumber *totalFee;
@property (nonatomic, strong, readonly) CLQFeeDetails *feeDetails;
@property (nonatomic, strong, readonly) NSNumber *totalFeeTaxes;
@property (nonatomic, strong, readonly) NSNumber *transferAmount;
@property (nonatomic, assign, readonly, getter=isPaid) BOOL paid;
@property (nonatomic, copy, readonly) NSString *statementDescriptor;
@property (nonatomic, strong, readonly) CLQOperation *operation;

@end
NS_ASSUME_NONNULL_END
