//
//  CLQCharge.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQCharge.h"

#import "CLQToken.h"
#import "CLQCard.h"
#import "CLQClient.h"
#import "CLQOutcome.h"
#import "CLQFeeDetails.h"
#import "CLQAntifraudDetails.h"
#import "CLQOperation.h"

@implementation CLQCharge

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *object = [data objectForKey:@"object"];
    NSString *identifier = [data objectForKey:@"id"];
    NSNumber *creationDate = [data objectForKey:@"creation_date"];
    NSNumber *amount = [data objectForKey:@"amount"];
    NSNumber *amountRefunded = [data objectForKey:@"amount_refunded"];
    NSNumber *currentAmount = [data objectForKey:@"current_amount"];
    NSNumber *installments = [data objectForKey:@"installments"];
    NSNumber *installmentsAmount = [data objectForKey:@"installments_amount"];
    NSString *currencyCode = [data objectForKey:@"currency_code"];
    NSString *email = [data objectForKey:@"email"];
    NSString *descriptionText = [data objectForKey:@"description"];
    NSDictionary *sourceData = [data objectForKey:@"source"];
    NSDictionary *outcomeData = [data objectForKey:@"outcome"];
    NSNumber *fraudScore = [data objectForKey:@"fraud_score"];
    NSDictionary *antifraudDetailsData = [data objectForKey:@"antifraud_details"];
    NSNumber *dispute = [data objectForKey:@"dispute"];
    NSNumber *capture = [data objectForKey:@"capture"];
    NSString *referenceCode = [data objectForKey:@"reference_code"];
    NSNumber *duplicated = [data objectForKey:@"duplicated"];
    NSDictionary *metadata = [data objectForKey:@"metadata"];
    NSNumber *totalFee = [data objectForKey:@"total_fee"];
    NSDictionary *feeDetailsData = [data objectForKey:@"fee_details"];
    NSNumber *totalFeeTaxes = [data objectForKey:@"total_fee_taxes"];
    NSNumber *transferAmount = [data objectForKey:@"transfer_amount"];
    NSNumber *paid = [data objectForKey:@"paid"];
    NSString *statementDescriptor = [data objectForKey:@"statement_descriptor"];
    NSDictionary *operationsData = [data objectForKey:@"operations"];
    NSDictionary *clientData = [data objectForKey:@"client"];
    
    return [[CLQCharge alloc] initWithObject:object identifier:identifier creationDate:creationDate amount:amount amountRefunded:amountRefunded currentAmount:currentAmount installments:installments installmentsAmount:installmentsAmount currencyCode:currencyCode email:email descriptionText:descriptionText sourceData:sourceData outcomeData:outcomeData fraudScore:fraudScore antifraudDetailsData:antifraudDetailsData dispute:dispute capture:capture referenceCode:referenceCode duplicated:duplicated metadata:metadata totalFee:totalFee feeDetailsData:feeDetailsData totalFeeTaxes:totalFeeTaxes transferAmount:transferAmount paid:paid statementDescriptor:statementDescriptor operationsData:operationsData clientData:clientData];
}

- (instancetype)initWithObject:(NSString *)object
                    identifier:(NSString *)identifier
                  creationDate:(NSNumber *)creationDate
                        amount:(NSNumber *)amount
                amountRefunded:(NSNumber *)amountRefunded
                 currentAmount:(NSNumber *)currentAmount
                  installments:(NSNumber *)installments
            installmentsAmount:(NSNumber *)installmentsAmount
                  currencyCode:(NSString *)currencyCode
                         email:(NSString *)email
               descriptionText:(NSString *)descriptionText
                    sourceData:(NSDictionary *)sourceData
                   outcomeData:(NSDictionary *)outcomeData
                    fraudScore:(NSNumber *)fraudScore
          antifraudDetailsData:(NSDictionary *)antifraudDetailsData
                       dispute:(NSNumber *)dispute
                       capture:(NSNumber *)capture
                 referenceCode:(NSString *)referenceCode
                    duplicated:(NSNumber *)duplicated
                      metadata:(NSDictionary *)metadata
                      totalFee:(NSNumber *)totalFee
                feeDetailsData:(NSDictionary *)feeDetailsData
                 totalFeeTaxes:(NSNumber *)totalFeeTaxes
                transferAmount:(NSNumber *)transferAmount
                          paid:(NSNumber *)paid
           statementDescriptor:(NSString *)statementDescriptor
                operationsData:(NSDictionary *)operationsData
                    clientData:(NSDictionary *)clientData {
    
    self = [super init];
    if (self) {
        if ([object isKindOfClass:[NSString class]])_object = object;
        if ([identifier isKindOfClass:[NSString class]])_identifier = identifier;
        if ([creationDate isKindOfClass:[NSNumber class]])_creationDate = [NSDate dateWithTimeIntervalSince1970:creationDate.doubleValue];
        if ([amount isKindOfClass:[NSNumber class]])_amount = amount;
        if ([amountRefunded isKindOfClass:[NSNumber class]])_amountRefunded = amountRefunded;
        if ([currentAmount isKindOfClass:[NSNumber class]])_currentAmount = currentAmount;
        if ([installments isKindOfClass:[NSNumber class]])_installments = installments;
        if ([installmentsAmount isKindOfClass:[NSNumber class]])_installmentsAmount = installmentsAmount;
        if ([currencyCode isKindOfClass:[NSNumber class]])_currencyCode = currencyCode;
        if ([email isKindOfClass:[NSString class]])_email = email;
        if ([descriptionText isKindOfClass:[NSString class]])_descriptionText = descriptionText;
        if ([sourceData isKindOfClass:[NSDictionary class]]) {
            if ([[sourceData objectForKey:@"object"] isEqualToString:@"token"]) {
                _token = [CLQToken newWithData:sourceData];
            }else{
                _card = [CLQCard newWithData:sourceData];
            }
        }
        if ([outcomeData isKindOfClass:[NSDictionary class]])_outcome = [CLQOutcome newWithData:outcomeData];
        if ([fraudScore isKindOfClass:[NSNumber class]])_fraudScore = fraudScore;
        if ([antifraudDetailsData isKindOfClass:[NSDictionary class]])_antifraudDetails = [CLQAntifraudDetails newWithData:antifraudDetailsData];
        if ([dispute isKindOfClass:[NSNumber class]])_disputed = dispute.boolValue;
        if ([capture isKindOfClass:[NSNumber class]])_captured = capture.boolValue;
        if ([referenceCode isKindOfClass:[NSString class]])_referenceCode = referenceCode;
        if ([duplicated isKindOfClass:[NSNumber class]])_duplicated = duplicated.boolValue;
        if ([metadata isKindOfClass:[NSDictionary class]])_metadata = metadata;
        if ([totalFee isKindOfClass:[NSNumber class]])_totalFee = totalFee;
        if ([feeDetailsData isKindOfClass:[NSDictionary class]])_feeDetails = [CLQFeeDetails newWithData:feeDetailsData];
        if ([totalFeeTaxes isKindOfClass:[NSNumber class]])_totalFeeTaxes = totalFeeTaxes;
        if ([transferAmount isKindOfClass:[NSNumber class]])_transferAmount = transferAmount;
        if ([paid isKindOfClass:[NSNumber class]])_paid = paid.boolValue;
        if ([statementDescriptor isKindOfClass:[NSString class]])_statementDescriptor = statementDescriptor;
        if ([operationsData isKindOfClass:[NSDictionary class]])_operation = [CLQOperation newWithData:operationsData];
        if ([clientData isKindOfClass:[NSDictionary class]])_client = [CLQClient newWithData:clientData];
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
        _amount = [aDecoder decodeObjectOfClass:[self class] forKey:@"amount"];
        _amountRefunded = [aDecoder decodeObjectOfClass:[self class] forKey:@"amountRefunded"];
        
        _currentAmount = [aDecoder decodeObjectOfClass:[self class] forKey:@"currentAmount"];
        _installments = [aDecoder decodeObjectOfClass:[self class] forKey:@"installments"];
        _installmentsAmount = [aDecoder decodeObjectOfClass:[self class] forKey:@"installmentsAmount"];
        _currencyCode = [aDecoder decodeObjectOfClass:[self class] forKey:@"currencyCode"];
        _email = [aDecoder decodeObjectOfClass:[self class] forKey:@"email"];
        
        _descriptionText = [aDecoder decodeObjectOfClass:[self class] forKey:@"descriptionText"];
        _token = [aDecoder decodeObjectOfClass:[self class] forKey:@"token"];
        _card = [aDecoder decodeObjectOfClass:[self class] forKey:@"card"];
        _outcome = [aDecoder decodeObjectOfClass:[self class] forKey:@"outcome"];
        _fraudScore = [aDecoder decodeObjectOfClass:[self class] forKey:@"fraudScore"];
        
        _antifraudDetails = [aDecoder decodeObjectOfClass:[self class] forKey:@"antifraudDetails"];
        _disputed = [[aDecoder decodeObjectOfClass:[self class] forKey:@"disputed"] boolValue];
        _captured = [[aDecoder decodeObjectOfClass:[self class] forKey:@"captured"] boolValue];
        _referenceCode = [aDecoder decodeObjectOfClass:[self class] forKey:@"referenceCode"];
        _duplicated = [[aDecoder decodeObjectOfClass:[self class] forKey:@"duplicated"] boolValue];
        
        _metadata = [aDecoder decodeObjectOfClass:[self class] forKey:@"metadata"];
        _totalFee = [aDecoder decodeObjectOfClass:[self class] forKey:@"totalFee"];
        _feeDetails = [aDecoder decodeObjectOfClass:[self class] forKey:@"feeDetails"];
        _totalFeeTaxes = [aDecoder decodeObjectOfClass:[self class] forKey:@"totalFeeTaxes"];
        _transferAmount = [aDecoder decodeObjectOfClass:[self class] forKey:@"transferAmount"];
        
        _paid = [[aDecoder decodeObjectOfClass:[self class] forKey:@"paid"] boolValue];
        _statementDescriptor = [aDecoder decodeObjectOfClass:[self class] forKey:@"statementDescriptor"];
        _operation = [aDecoder decodeObjectOfClass:[self class] forKey:@"operation"];
        _client = [aDecoder decodeObjectOfClass:[self class] forKey:@"client"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_object forKey:@"object"];
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_creationDate forKey:@"creationDate"];
    [aCoder encodeObject:_amount forKey:@"amount"];
    [aCoder encodeObject:_amountRefunded forKey:@"amountRefunded"];
    
    [aCoder encodeObject:_currentAmount forKey:@"currentAmount"];
    [aCoder encodeObject:_installments forKey:@"installments"];
    [aCoder encodeObject:_installmentsAmount forKey:@"installmentsAmount"];
    [aCoder encodeObject:_currencyCode forKey:@"currencyCode"];
    [aCoder encodeObject:_email forKey:@"email"];
    
    [aCoder encodeObject:_descriptionText forKey:@"descriptionText"];
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_card forKey:@"card"];
    [aCoder encodeObject:_outcome forKey:@"outcome"];
    [aCoder encodeObject:_fraudScore forKey:@"fraudScore"];
    
    [aCoder encodeObject:_antifraudDetails forKey:@"antifraudDetails"];
    [aCoder encodeObject:@(_disputed) forKey:@"disputed"];
    [aCoder encodeObject:@(_captured) forKey:@"captured"];
    [aCoder encodeObject:_referenceCode forKey:@"referenceCode"];
    [aCoder encodeObject:@(_duplicated) forKey:@"duplicated"];
    
    [aCoder encodeObject:_metadata forKey:@"metadata"];
    [aCoder encodeObject:_totalFee forKey:@"totalFee"];
    [aCoder encodeObject:_feeDetails forKey:@"feeDetails"];
    [aCoder encodeObject:_totalFeeTaxes forKey:@"totalFeeTaxes"];
    [aCoder encodeObject:_transferAmount forKey:@"transferAmount"];
    
    [aCoder encodeObject:@(_paid) forKey:@"paid"];
    [aCoder encodeObject:_statementDescriptor forKey:@"statementDescriptor"];
    [aCoder encodeObject:_operation forKey:@"operation"];
    [aCoder encodeObject:_client forKey:@"client"];
}

@end
