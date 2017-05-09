//
//  CLQWebServices.h
//  Culqi
//
//  Created by Guillermo Sáenz on 9/18/16.
//  Copyright (c) 2016 Guillermo Sáenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLQResponseHeaders, CLQError, CLQPaging;
@class CLQToken, CLQCharge, CLQRefund, CLQCustomer, CLQCard, CLQPlan, CLQSubscription;
@class CLQAntifraudDetails;

NS_ASSUME_NONNULL_BEGIN
@interface CLQWebServices : NSObject

#pragma mark - Auth

+ (void)setAutorizationHeaderFieldWithMerchantCode:(NSString *)merchantCode;

#pragma mark - Tokens

+ (void)createTokenWithCardNumber:(NSString *)cardNumber
                              cvv:(NSString *)cvv
                  expirationMonth:(NSString *)expirationMonth
                   expirationYear:(NSString *)expirationYear
                            email:(NSString *)email
                         metadata:(NSDictionary *)metadata
                          success:(void (^)(CLQResponseHeaders *responseHeaders, CLQToken *token))success
                          failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getTokenWithIdentifier:(NSString *)tokenIdentifier
                       success:(void (^)(CLQResponseHeaders *responseHeaders, CLQToken *token))success
                       failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getTokensWithFromUnixDate:(NSNumber *)fromUnixDate
                       toUnixDate:(NSNumber *)toUnixDate
                        cardBrand:(NSString *)cardBrand
                         cardType:(NSString *)cardType
                       deviceType:(NSString *)deviceType
                              bin:(NSNumber *)bin
                      countryCode:(NSString *)countryCode
                            limit:(NSNumber *)limit
            beforeTokenIdentifier:(NSString *)beforeTokenIdentifier
             afterTokenIdentifier:(NSString *)afterTokenIdentifier
                          success:(void (^)(CLQResponseHeaders *responseHeaders, CLQPaging *paging, NSArray <CLQToken *> *tokens))success
                          failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)updateTokenWithIdentifier:(NSString *)tokenIdentifier
                         metadata:(NSDictionary *)metadata
                          success:(void (^)(CLQResponseHeaders *responseHeaders, CLQToken *token))success
                          failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

#pragma mark - Charges

+ (void)createChargeWithAmount:(NSNumber *)amount
                  currencyCode:(NSString *)currencyCode
                         email:(NSString *)email
              antifraudDetails:(CLQAntifraudDetails *)antifraudDetails
              sourceIdentifier:(NSString *)sourceIdentifier
                       success:(void (^)(CLQResponseHeaders *responseHeaders, CLQCharge *charge))success
                       failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getChargeWithIdentifier:(NSString *)chargeIdentifier
                        success:(void (^)(CLQResponseHeaders *responseHeaders, CLQCharge *charge))success
                        failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getChargesWithAmount:(NSNumber *)amount
               minimumAmount:(NSNumber *)minimumAmount
               maximumAmount:(NSNumber *)maximumAmount
                installments:(NSNumber *)installments
         minimumInstallments:(NSNumber *)minimumInstallments
         maximumInstallments:(NSNumber *)maximumInstallments
                currencyCode:(NSString *)currencyCode
                        code:(NSString *)code
                declinedCode:(NSString *)declinedCode
                  fraudScore:(NSNumber *)fraudScore
           minimumFraudScore:(NSNumber *)minimumFraudScore
           maximumFraudScore:(NSNumber *)maximumFraudScore
                   firstName:(NSString *)firstName
                    lastName:(NSString *)lastName
                       email:(NSString *)email
                     address:(NSString *)address
                 addressCity:(NSString *)addressCity
                 phoneNumber:(NSString *)phoneNumber
                 countryCode:(NSString *)countryCode
                    disputed:(NSNumber *)disputed
                    captured:(NSNumber *)captured
                  duplicated:(NSNumber *)duplicated
                        paid:(NSNumber *)paid
          customerIdentifier:(NSString *)customerIdentifier
               referenceCode:(NSString *)referenceCode
                    unixDate:(NSNumber *)unixDate
                fromUnixDate:(NSNumber *)fromUnixDate
                  toUnixDate:(NSNumber *)toUnixDate
                         fee:(NSNumber *)fee
                  minimumFee:(NSNumber *)minimumFee
                  maximumFee:(NSNumber *)maximumFee
                   cardBrand:(NSString *)cardBrand
                    cardType:(NSString *)cardType
                  deviceType:(NSString *)deviceType
                         bin:(NSNumber *)bin
                       limit:(NSNumber *)limit
      beforeChargeIdentifier:(NSString *)beforeChargeIdentifier
       afterChargeIdentifier:(NSString *)afterChargeIdentifier
                     success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                     failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)updateChargeWithIdentifier:(NSString *)chargeIdentifier
                          metadata:(NSDictionary *)metadata
                           success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                           failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)deleteChargeWithIdentifier:(NSString *)chargeIdentifier
                           success:(void (^)())success
                           failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

#pragma mark - Refunds

+ (void)createRefundWithChargeIdentifier:(NSString *)chargeIdentifier
                                  amount:(NSNumber *)amount
                                  reason:(NSString *)reason
                                metadata:(NSDictionary *)metadata
                                 success:(void (^)(CLQResponseHeaders *responseHeaders, CLQRefund *refund))success
                                 failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getRefundWithIdentifier:(NSString *)refundIdentifier
                        success:(void (^)(CLQResponseHeaders *responseHeaders, CLQRefund *refund))success
                        failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getRefundsWithUnixDate:(NSNumber *)unixDate
                  fromUnixDate:(NSNumber *)fromUnixDate
                    toUnixDate:(NSNumber *)toUnixDate
                        reason:(NSString *)reason
                         limit:(NSNumber *)limit
        beforeRefundIdentifier:(NSString *)beforeRefundIdentifier
         afterRefundIdentifier:(NSString *)afterRefundIdentifier
                       success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                       failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)updateRefundWithIdentifier:(NSString *)refundIdentifier
                          metadata:(NSDictionary *)metadata
                           success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                           failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

#pragma mark - Customers

+ (void)createCustomerWithFirstName:(NSString *)firstName
                           lastName:(NSString *)lastName
                              email:(NSString *)email
                            address:(NSString *)address
                        addressCity:(NSString *)addressCity
                        countryCode:(NSString *)countryCode
                        phoneNumber:(NSString *)phoneNumber
                           metadata:(NSDictionary *)metadata
                            success:(void (^)(CLQResponseHeaders *responseHeaders, CLQCustomer *customer))success
                            failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getCustomerWithIdentifier:(NSString *)customerIdentifier
                          success:(void (^)(CLQResponseHeaders *responseHeaders, CLQCustomer *customer))success
                          failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getCustomersWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
                            email:(NSString *)email
                          address:(NSString *)address
                      addressCity:(NSString *)addressCity
                      phoneNumber:(NSString *)phoneNumber
                      countryCode:(NSString *)countryCode
                            limit:(NSNumber *)limit
         beforeCustomerIdentifier:(NSString *)beforeCustomerIdentifier
          afterCustomerIdentifier:(NSString *)afterCustomerIdentifier
                          success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                          failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)updateCustomerWithIdentifier:(NSString *)customerIdentifier
                            metadata:(NSDictionary *)metadata
                             success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                             failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)deleteCustomerWithIdentifier:(NSString *)customerIdentifier
                             success:(void (^)())success
                             failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

#pragma mark - Cards

+ (void)createCardWithIdentifier:(NSString *)customerIdentifier
                 tokenIdentifier:(NSString *)tokenIdentifier
                  shouldValidate:(BOOL)shouldValidate
                        metadata:(NSDictionary *)metadata
                         success:(void (^)(CLQResponseHeaders *responseHeaders, CLQCard *card))success
                         failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getCardWithIdentifier:(NSString *)cardIdentifier
                      success:(void (^)(CLQResponseHeaders *responseHeaders, CLQCard *card))success
                      failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getCardsWithUnixDate:(NSNumber *)unixDate
                fromUnixDate:(NSNumber *)fromUnixDate
                  toUnixDate:(NSNumber *)toUnixDate
                   cardBrand:(NSString *)cardBrand
                    cardType:(NSString *)cardType
                  deviceType:(NSString *)deviceType
                         bin:(NSString *)bin
                 countryCode:(NSString *)countryCode
                       limit:(NSNumber *)limit
    beforeCustomerIdentifier:(NSString *)beforeCustomerIdentifier
     afterCustomerIdentifier:(NSString *)afterCustomerIdentifier
                     success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                     failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)updateCardWithIdentifier:(NSString *)cardIdentifier
                        metadata:(NSDictionary *)metadata
                         success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                         failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)deleteCardWithIdentifier:(NSString *)cardIdentifier
                         success:(void (^)())success
                         failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

#pragma mark - Plans

+ (void)createPlanWithName:(NSString *)name
                    amount:(NSNumber *)amount
              currencyCode:(NSString *)currencyCode
                  interval:(NSString *)interval // TODO: Ask devs
             intervalCount:(NSNumber *)intervalCount
                 trialDays:(NSNumber *)trialDays
                     limit:(NSNumber *)limit
                  metadata:(NSDictionary *)metadata
                   success:(void (^)(CLQResponseHeaders *responseHeaders, CLQPlan *plan))success
                   failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getPlanWithIdentifier:(NSString *)planIdentifier
                      success:(void (^)(CLQResponseHeaders *responseHeaders, CLQPlan *plan))success
                      failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getPlansWithAmount:(NSNumber *)amount
                 minAmount:(NSNumber *)minAmount
                 maxAmount:(NSNumber *)maxAmount
              fromUnixDate:(NSNumber *)fromUnixDate
                toUnixDate:(NSNumber *)toUnixDate
                     limit:(NSNumber *)limit
      beforePlanIdentifier:(NSString *)beforePlanIdentifier
       afterPlanIdentifier:(NSString *)afterPlanIdentifier
                   success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                   failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)updatePlanWithIdentifier:(NSString *)planIdentifier
                        metadata:(NSDictionary *)metadata
                         success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                         failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)deletePlanWithIdentifier:(NSString *)planIdentifier
                         success:(void (^)())success
                         failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

#pragma mark - Subscriptions

+ (void)createSubscriptionWithCardIdentifier:(NSString *)cardIdentifier
                              planIdentifier:(NSString *)planIdentifier
                                    metadata:(NSDictionary *)metadata
                                     success:(void (^)(CLQResponseHeaders *responseHeaders, CLQSubscription *subscription))success
                                     failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getSubscriptionWithIdentifier:(NSString *)subscriptionIdentifier
                              success:(void (^)(CLQResponseHeaders *responseHeaders, CLQSubscription *subscription))success
                              failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)getSubscriptionsWithAmount:(NSNumber *)amount
                     minimumAmount:(NSNumber *)minimumAmount
                     maximumAmount:(NSNumber *)maximumAmount
                          unixDate:(NSNumber *)unixDate
                      fromUnixDate:(NSNumber *)fromUnixDate
                        toUnixDate:(NSNumber *)toUnixDate
                          interval:(NSString *)interval
                            status:(NSString *)status
                             limit:(NSNumber *)limit
      beforeSubscriptionIdentifier:(NSString *)beforeSubscriptionIdentifier
       afterSubscriptionIdentifier:(NSString *)afterSubscriptionIdentifier
                           success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                           failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)updateSubscriptionWithIdentifier:(NSString *)subscriptionIdentifier
                                metadata:(NSDictionary *)metadata
                                 success:(void (^)(CLQResponseHeaders *responseHeaders, NSDictionary *responseObject))success
                                 failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

+ (void)deleteSubscriptionWithIdentifier:(NSString *)subscriptionIdentifier
                                 success:(void (^)())success
                                 failure:(void (^)(CLQResponseHeaders *responseHeaders, CLQError *businessError, NSError *error))failure;

@end
NS_ASSUME_NONNULL_END
