//
//  Culqi.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLQResponseHeaders, CLQError, CLQPaging;
@class CLQToken, CLQCharge, CLQRefund, CLQCustomer, CLQCard, CLQPlan, CLQSubscription;
@class CLQAntifraudDetails;

#import "CLQIssuerIdentificationNumber.h"
#import "CLQCurrencyCode.h"

@interface Culqi : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (Culqi *_Nonnull)sharedInstance;

+ (void)setApiKey:(NSString *_Nonnull)apiKey;

#pragma mark - Tokens

- (void)createTokenWithCardNumber:(NSString *_Nonnull)cardNumber
                              cvv:(NSString *_Nonnull)cvv
                  expirationMonth:(NSString *_Nonnull)expirationMonth
                   expirationYear:(NSString *_Nonnull)expirationYear
                            email:(NSString *_Nonnull)email
                         metadata:(NSDictionary * _Nullable)metadata
                          success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQToken * _Nonnull token))success
                          failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error))failure;

- (void)getTokenWithIdentifier:(NSString *_Nonnull)tokenIdentifier
                       success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQToken *_Nonnull token))success
                       failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;

- (void)getTokensWithFromUnixDate:(NSNumber*_Nullable)fromUnixDate
                       toUnixDate:(NSNumber*_Nullable)toUnixDate
                        cardBrand:(NSString*_Nullable)cardBrand
                         cardType:(CLQCardType)cardType
                       deviceType:(NSString*_Nullable)deviceType
                              bin:(NSNumber*_Nullable)bin
                      countryCode:(NSString*_Nullable)countryCode
                            limit:(NSNumber*_Nullable)limit
            beforeTokenIdentifier:(NSString*_Nullable)beforeTokenIdentifier
             afterTokenIdentifier:(NSString*_Nullable)afterTokenIdentifier
                          success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQPaging *_Nonnull paging, NSArray <CLQToken *> *_Nonnull tokens))success
                          failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;

- (void)updateTokenWithIdentifier:(NSString *_Nonnull)tokenIdentifier
                         metadata:(NSDictionary *_Nonnull)metadata
                          success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQToken *_Nonnull token))success
                          failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;

#pragma mark - Charges

- (void)createChargeWithAmount:(NSNumber *_Nonnull)amount
                       capture:(BOOL)capture
                  currencyCode:(CLQCurrencyCodeType)currencyCode
                   description:(NSString *_Nullable)description
                         email:(NSString *_Nonnull)email
                  installments:(NSNumber *_Nullable)installments
              antifraudDetails:(CLQAntifraudDetails *_Nullable)antifraudDetails
              sourceIdentifier:(NSString *_Nonnull)sourceIdentifier
                      metadata:(NSDictionary *_Nullable)metadata
                       success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQCharge *_Nonnull charge))success
                       failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;

- (void)getChargeWithIdentifier:(NSString *_Nonnull)chargeIdentifier
                        success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQCharge *_Nonnull charge))success
                        failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;

- (void)getChargesWithAmount:(NSNumber *_Nullable)amount
               minimumAmount:(NSNumber *_Nullable)minimumAmount
               maximumAmount:(NSNumber *_Nullable)maximumAmount
                installments:(NSNumber *_Nullable)installments
         minimumInstallments:(NSNumber *_Nullable)minimumInstallments
         maximumInstallments:(NSNumber *_Nullable)maximumInstallments
            currencyCodeType:(CLQCurrencyCodeType)currencyCodeType
                        code:(NSString *_Nullable)code
                declinedCode:(NSString *_Nullable)declinedCode
                  fraudScore:(NSNumber *_Nullable)fraudScore
           minimumFraudScore:(NSNumber *_Nullable)minimumFraudScore
           maximumFraudScore:(NSNumber *_Nullable)maximumFraudScore
                   firstName:(NSString *_Nullable)firstName
                    lastName:(NSString *_Nullable)lastName
                       email:(NSString *_Nullable)email
                     address:(NSString *_Nullable)address
                 addressCity:(NSString *_Nullable)addressCity
                 phoneNumber:(NSString *_Nullable)phoneNumber
                 countryCode:(NSString *_Nullable)countryCode
                    disputed:(NSNumber *_Nullable)disputed
                    captured:(NSNumber *_Nullable)captured
                  duplicated:(NSNumber *_Nullable)duplicated
                        paid:(NSNumber *_Nullable)paid
          customerIdentifier:(NSString *_Nullable)customerIdentifier
               referenceCode:(NSString *_Nullable)referenceCode
                    unixDate:(NSNumber *_Nullable)unixDate
                fromUnixDate:(NSNumber *_Nullable)fromUnixDate
                  toUnixDate:(NSNumber *_Nullable)toUnixDate
                         fee:(NSNumber *_Nullable)fee
                  minimumFee:(NSNumber *_Nullable)minimumFee
                  maximumFee:(NSNumber *_Nullable)maximumFee
                   cardBrand:(NSString *_Nullable)cardBrand
                    cardType:(CLQCardType)cardType
                  deviceType:(NSString *_Nullable)deviceType
                         bin:(NSNumber *_Nullable)bin
                       limit:(NSNumber *_Nullable)limit
      beforeChargeIdentifier:(NSString *_Nullable)beforeChargeIdentifier
       afterChargeIdentifier:(NSString *_Nullable)afterChargeIdentifier
                     success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQPaging *_Nonnull paging, NSArray <CLQCharge *> *_Nonnull charges))success
                     failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;

- (void)updateChargeWithIdentifier:(NSString *_Nonnull)chargeIdentifier
                          metadata:(NSDictionary *_Nonnull)metadata
                           success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQCharge *_Nonnull charge))success
                           failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;

- (void)deleteChargeWithIdentifier:(NSString *_Nonnull)chargeIdentifier
                           success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders))success
                           failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;

@end
