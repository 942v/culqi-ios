//
//  CLQWebServices.h
//  Culqi
//
//  Created by Guillermo Sáenz on 9/18/16.
//  Copyright (c) 2016 Guillermo Sáenz. All rights reserved.
//

#import <Foundation/Foundation.h>

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
                          success:(void (^)(NSDictionary *responseObject))success
                          failure:(void (^)(NSError *error))failure;

+ (void)getTokenWithIdentifier:(NSString *)tokenIdentifier
                       success:(void (^)(NSDictionary *responseObject))success
                       failure:(void (^)(NSError *error))failure;

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
                          success:(void (^)(NSDictionary *responseObject))success
                          failure:(void (^)(NSError *error))failure;

+ (void)updateTokenWithIdentifier:(NSString *)tokenIdentifier
                         metadata:(NSDictionary *)metadata
                          success:(void (^)(NSDictionary *responseObject))success
                          failure:(void (^)(NSError *error))failure;

#pragma mark - Plans

+ (void)createPlanWithName:(NSString *)name
                    amount:(NSNumber *)amount
              currencyCode:(NSString *)currencyCode
                  interval:(NSString *)interval // TODO: Ask devs
             intervalCount:(NSNumber *)intervalCount
                 trialDays:(NSNumber *)trialDays
                     limit:(NSNumber *)limit
                  metadata:(NSDictionary *)metadata
                   success:(void (^)(NSDictionary *responseObject))success
                   failure:(void (^)(NSError *error))failure;

+ (void)getPlanWithIdentifier:(NSString *)planIdentifier
                      success:(void (^)(NSDictionary *responseObject))success
                      failure:(void (^)(NSError *error))failure;

+ (void)getPlansWithAmount:(NSNumber *)amount
                 minAmount:(NSNumber *)minAmount
                 maxAmount:(NSNumber *)maxAmount
              fromUnixDate:(NSNumber *)fromUnixDate
                toUnixDate:(NSNumber *)toUnixDate
                     limit:(NSNumber *)limit
      beforePlanIdentifier:(NSString *)beforePlanIdentifier
       afterPlanIdentifier:(NSString *)afterPlanIdentifier
                   success:(void (^)(NSDictionary *responseObject))success
                   failure:(void (^)(NSError *error))failure;

+ (void)updatePlanWithIdentifier:(NSString *)planIdentifier
                        metadata:(NSDictionary *)metadata
                         success:(void (^)(NSDictionary *responseObject))success
                         failure:(void (^)(NSError *error))failure;

+ (void)deletePlanWithIdentifier:(NSString *)planIdentifier
                         success:(void (^)())success
                         failure:(void (^)(NSError *error))failure;

#pragma mark - Customers

+ (void)createCustomerWithFirstName:(NSString *)firstName
                           lastName:(NSString *)lastName
                              email:(NSString *)email
                            address:(NSString *)address
                        addressCity:(NSString *)addressCity
                        countryCode:(NSString *)countryCode
                        phoneNumber:(NSString *)phoneNumber
                           metadata:(NSDictionary *)metadata
                            success:(void (^)(NSDictionary *responseObject))success
                            failure:(void (^)(NSError *error))failure;

+ (void)getCustomerWithIdentifier:(NSString *)customerIdentifier
                          success:(void (^)(NSDictionary *responseObject))success
                          failure:(void (^)(NSError *error))failure;

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
                          success:(void (^)(NSDictionary *responseObject))success
                          failure:(void (^)(NSError *error))failure;

+ (void)updateCustomerWithIdentifier:(NSString *)customerIdentifier
                            metadata:(NSDictionary *)metadata
                             success:(void (^)(NSDictionary *responseObject))success
                             failure:(void (^)(NSError *error))failure;

+ (void)deleteCustomerWithIdentifier:(NSString *)customerIdentifier
                             success:(void (^)())success
                             failure:(void (^)(NSError *error))failure;

#pragma mark - Charges

#pragma mark - Subscriptions

#pragma mark - Cards

+ (void)createCardWithIdentifier:(NSString *)customerIdentifier
                 tokenIdentifier:(NSString *)tokenIdentifier
                  shouldValidate:(BOOL)shouldValidate
                        metadata:(NSDictionary *)metadata
                         success:(void (^)(NSDictionary *responseObject))success
                         failure:(void (^)(NSError *error))failure;

+ (void)getCardWithIdentifier:(NSString *)cardIdentifier
                      success:(void (^)(NSDictionary *responseObject))success
                      failure:(void (^)(NSError *error))failure;

+ (void)getCardsWithDate:(NSNumber *)date
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
                 success:(void (^)(NSDictionary *responseObject))success
                 failure:(void (^)(NSError *error))failure;

+ (void)updateCardWithIdentifier:(NSString *)cardIdentifier
                        metadata:(NSDictionary *)metadata
                         success:(void (^)(NSDictionary *responseObject))success
                         failure:(void (^)(NSError *error))failure;

+ (void)deleteCardWithIdentifier:(NSString *)cardIdentifier
                         success:(void (^)())success
                         failure:(void (^)(NSError *error))failure;

@end
NS_ASSUME_NONNULL_END
