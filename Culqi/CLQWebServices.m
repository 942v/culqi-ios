//
//  CLQWebServices.m
//  Culqi
//
//  Created by Guillermo Sáenz on 9/18/16.
//  Copyright (c) 2016 Guillermo Sáenz. All rights reserved.
//

#import "CLQWebServices.h"

#import "CLQHTTPSessionManager.h"

#import "CLQResponseHeaders.h"
#import "CLQToken.h"

@implementation CLQWebServices

#pragma mark - Auth

+ (void)setAutorizationHeaderFieldWithMerchantCode:(NSString *)merchantCode {
    
    [[CLQHTTPSessionManager manager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", merchantCode] forHTTPHeaderField:@"Authorization"];
}

#pragma mark - Tokens

+ (void)createTokenWithCardNumber:(NSString *)cardNumber
                              cvv:(NSString *)cvv
                  expirationMonth:(NSString *)expirationMonth
                   expirationYear:(NSString *)expirationYear
                            email:(NSString *)email
                         metadata:(nonnull NSDictionary *)metadata
                          success:(nonnull void (^)(CLQResponseHeaders * _Nonnull, CLQToken * _Nonnull))success
                          failure:(nonnull void (^)(CLQResponseHeaders * _Nonnull, NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (cardNumber) [parameters setObject:cardNumber forKey:@"card_number"];
    if (cvv) [parameters setObject:cvv forKey:@"cvv"];
    if (expirationMonth) [parameters setObject:expirationMonth forKey:@"expiration_month"];
    if (expirationYear) [parameters setObject:expirationYear forKey:@"expiration_year"];
    if (email) [parameters setObject:email forKey:@"email"];
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] POST:@"tokens" parameters:parameters.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) success ([CLQResponseHeaders newWithData:[self headersFromResponseTask:task]], [CLQToken newWithData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure([CLQResponseHeaders newWithData:[self headersFromResponseTask:task]], error);
    }];
}

+ (void)getTokenWithIdentifier:(NSString *)tokenIdentifier
                       success:(void (^)(NSDictionary * _Nonnull))success
                       failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] GET:[@"tokens" stringByAppendingFormat:@"/%@", tokenIdentifier] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

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
                          success:(void (^)(NSDictionary * _Nonnull))success
                          failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (fromUnixDate) [parameters setObject:fromUnixDate forKey:@"date"];
    if (toUnixDate) [parameters setObject:toUnixDate forKey:@"date_to"];
    if (cardBrand) [parameters setObject:cardBrand forKey:@"card_brand"];
    if (cardType) [parameters setObject:cardType forKey:@"card_type"];
    if (deviceType) [parameters setObject:deviceType forKey:@"device_type"];
    if (bin) [parameters setObject:bin forKey:@"bin"];
    if (countryCode) [parameters setObject:countryCode forKey:@"country_code"];
    if (limit) [parameters setObject:limit forKey:@"limit"];
    if (beforeTokenIdentifier) [parameters setObject:beforeTokenIdentifier forKey:@"before"];
    if (afterTokenIdentifier) [parameters setObject:afterTokenIdentifier forKey:@"after"];
    
    [[CLQHTTPSessionManager manager] GET:@"tokens" parameters:parameters.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)updateTokenWithIdentifier:(NSString *)tokenIdentifier
                         metadata:(NSDictionary *)metadata
                          success:(void (^)(NSDictionary * _Nonnull))success
                          failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] PATCH:[@"tokens" stringByAppendingFormat:@"/%@", tokenIdentifier] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - Charges

+ (void)createChargeWithAmount:(NSNumber *)amount
                  currencyCode:(NSString *)currencyCode
                         email:(NSString *)email
              antifraudDetails:(CLQAntifraudDetails *)antifraudDetails
              sourceIdentifier:(NSString *)sourceIdentifier
                       success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSDictionary *parameters = @{
                                 @"amount":amount,
                                 @"currencyCode":currencyCode,
                                 @"email":email,
                                 @"antifraudDetails":antifraudDetails, // TODO: change for Dictionary
                                 @"sourceIdentifier":sourceIdentifier
                                 };
    
    [[CLQHTTPSessionManager manager] POST:@"charges" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)getChargeWithIdentifier:(NSString *)chargeIdentifier
                        success:(void (^)(NSDictionary * _Nonnull))success
                        failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] GET:[@"charges" stringByAppendingFormat:@"/%@", chargeIdentifier] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

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
                     success:(void (^)(NSDictionary * _Nonnull))success
                     failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (amount) [parameters setObject:amount forKey:@"amount"];
    if (minimumAmount) [parameters setObject:minimumAmount forKey:@"min_amount"];
    if (maximumAmount) [parameters setObject:maximumAmount forKey:@"max_amount"];
    if (installments) [parameters setObject:installments forKey:@"installments"];
    if (minimumInstallments) [parameters setObject:minimumInstallments forKey:@"min_installments"];
    if (maximumInstallments) [parameters setObject:maximumInstallments forKey:@"max_installments"];
    if (currencyCode) [parameters setObject:currencyCode forKey:@"currency_code"];
    if (code) [parameters setObject:code forKey:@"code"];
    if (declinedCode) [parameters setObject:declinedCode forKey:@"decline_code"];
    if (fraudScore) [parameters setObject:fraudScore forKey:@"fraud_score"];
    if (minimumFraudScore) [parameters setObject:minimumFraudScore forKey:@"min_fraud_score"];
    if (maximumFraudScore) [parameters setObject:maximumFraudScore forKey:@"max_fraud_score"];
    if (firstName) [parameters setObject:firstName forKey:@"first_name"];
    if (lastName) [parameters setObject:lastName forKey:@"last_name"];
    if (email) [parameters setObject:email forKey:@"email"];
    if (address) [parameters setObject:address forKey:@"address"];
    if (addressCity) [parameters setObject:addressCity forKey:@"address_city"];
    if (phoneNumber) [parameters setObject:phoneNumber forKey:@"phone_number"];
    if (countryCode) [parameters setObject:countryCode forKey:@"country_code"];
    if (disputed) [parameters setObject:disputed forKey:@"dispute"];
    if (captured) [parameters setObject:captured forKey:@"captured"];
    if (duplicated) [parameters setObject:duplicated forKey:@"duplicated"];
    if (paid) [parameters setObject:paid forKey:@"paid"];
    if (customerIdentifier) [parameters setObject:customerIdentifier forKey:@"customer_id"];
    if (referenceCode) [parameters setObject:referenceCode forKey:@"reference"];
    if (unixDate) [parameters setObject:unixDate forKey:@"date"];
    if (fromUnixDate) [parameters setObject:fromUnixDate forKey:@"date_from"];
    if (toUnixDate) [parameters setObject:toUnixDate forKey:@"date_to"];
    if (fee) [parameters setObject:fee forKey:@"fee"];
    if (minimumFee) [parameters setObject:minimumFee forKey:@"min_fee"];
    if (maximumFee) [parameters setObject:maximumFee forKey:@"max_fee"];
    if (cardBrand) [parameters setObject:cardBrand forKey:@"card_brand"];
    if (cardType) [parameters setObject:cardType forKey:@"card_type"];
    if (deviceType) [parameters setObject:deviceType forKey:@"device_type"];
    if (bin) [parameters setObject:bin forKey:@"bin"];
    if (limit) [parameters setObject:limit forKey:@"limit"];
    if (beforeChargeIdentifier) [parameters setObject:beforeChargeIdentifier forKey:@"before"];
    if (afterChargeIdentifier) [parameters setObject:afterChargeIdentifier forKey:@"after"];
    
    [[CLQHTTPSessionManager manager] GET:@"charges" parameters:parameters.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)updateChargeWithIdentifier:(NSString *)chargeIdentifier
                          metadata:(NSDictionary *)metadata
                           success:(void (^)(NSDictionary * _Nonnull))success
                           failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] PATCH:[@"charges" stringByAppendingFormat:@"/%@", chargeIdentifier] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)deleteChargeWithIdentifier:(NSString *)chargeIdentifier
                           success:(void (^)())success
                           failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] DELETE:[@"charges" stringByAppendingFormat:@"/%@", chargeIdentifier] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success ();// TODO: shouldn't this be a 204?
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - Refunds

+ (void)createRefundWithChargeIdentifier:(NSString *)chargeIdentifier
                                  amount:(NSNumber *)amount
                                  reason:(NSString *)reason
                                metadata:(NSDictionary *)metadata
                                 success:(void (^)(NSDictionary * _Nonnull))success
                                 failure:(void (^)(NSError * _Nonnull))failure {
    
    NSDictionary *parameters = @{
                                 @"amount":amount,
                                 @"charge_id":chargeIdentifier,
                                 @"reason":reason,
                                 @"metadata":metadata
                                 };
    
    [[CLQHTTPSessionManager manager] POST:@"refunds" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)getRefundWithIdentifier:(NSString *)refundIdentifier
                        success:(void (^)(NSDictionary * _Nonnull))success
                        failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] GET:[@"refunds" stringByAppendingFormat:@"/%@", refundIdentifier] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)getRefundsWithUnixDate:(NSNumber *)unixDate
                  fromUnixDate:(NSNumber *)fromUnixDate
                    toUnixDate:(NSNumber *)toUnixDate
                        reason:(NSString *)reason
                         limit:(NSNumber *)limit
        beforeRefundIdentifier:(NSString *)beforeRefundIdentifier
         afterRefundIdentifier:(NSString *)afterRefundIdentifier
                       success:(void (^)(NSDictionary * _Nonnull))success
                       failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (unixDate) [parameters setObject:unixDate forKey:@"date"];
    if (fromUnixDate) [parameters setObject:fromUnixDate forKey:@"date_from"];
    if (toUnixDate) [parameters setObject:toUnixDate forKey:@"date_to"];
    if (reason) [parameters setObject:reason forKey:@"reason"];
    if (limit) [parameters setObject:limit forKey:@"limit"];
    if (beforeRefundIdentifier) [parameters setObject:beforeRefundIdentifier forKey:@"before"];
    if (afterRefundIdentifier) [parameters setObject:afterRefundIdentifier forKey:@"after"];
    
    [[CLQHTTPSessionManager manager] GET:@"refunds" parameters:parameters.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)updateRefundWithIdentifier:(NSString *)refundIdentifier
                          metadata:(NSDictionary *)metadata
                           success:(void (^)(NSDictionary * _Nonnull))success
                           failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] PATCH:[@"refunds" stringByAppendingFormat:@"/%@", refundIdentifier] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - Customers

+ (void)createCustomerWithFirstName:(NSString *)firstName
                           lastName:(NSString *)lastName
                              email:(NSString *)email
                            address:(NSString *)address
                        addressCity:(NSString *)addressCity
                        countryCode:(NSString *)countryCode
                        phoneNumber:(NSString *)phoneNumber
                           metadata:(NSDictionary *)metadata
                            success:(void (^)(NSDictionary * _Nonnull))success
                            failure:(void (^)(NSError * _Nonnull))failure {
    
    NSDictionary *parameters = @{
                                 @"first_name":firstName,
                                 @"last_name":lastName,
                                 @"email":email,
                                 @"address":address,
                                 @"address_city":addressCity,
                                 @"country_code":countryCode,
                                 @"phone_number":phoneNumber,
                                 @"metadata":metadata
                                 };
    
    [[CLQHTTPSessionManager manager] POST:@"customers" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)getCustomerWithIdentifier:(NSString *)customerIdentifier
                          success:(void (^)(NSDictionary * _Nonnull))success
                          failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] GET:[@"customers" stringByAppendingFormat:@"/%@", customerIdentifier] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

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
                          success:(void (^)(NSDictionary * _Nonnull))success
                          failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (firstName) [parameters setObject:firstName forKey:@"first_name"];
    if (lastName) [parameters setObject:lastName forKey:@"last_name"];
    if (email) [parameters setObject:email forKey:@"email"];
    if (address) [parameters setObject:address forKey:@"address"];
    if (addressCity) [parameters setObject:addressCity forKey:@"address_city"];
    if (phoneNumber) [parameters setObject:phoneNumber forKey:@"phone_number"];
    if (countryCode) [parameters setObject:countryCode forKey:@"country_code"];
    if (limit) [parameters setObject:limit forKey:@"limit"];
    if (beforeCustomerIdentifier) [parameters setObject:beforeCustomerIdentifier forKey:@"before"];
    if (afterCustomerIdentifier) [parameters setObject:afterCustomerIdentifier forKey:@"after"];
    
    [[CLQHTTPSessionManager manager] GET:@"customers" parameters:parameters.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)updateCustomerWithIdentifier:(NSString *)customerIdentifier
                            metadata:(NSDictionary *)metadata
                             success:(void (^)(NSDictionary * _Nonnull))success
                             failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] PATCH:[@"customers" stringByAppendingFormat:@"/%@", customerIdentifier] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)deleteCustomerWithIdentifier:(NSString *)customerIdentifier
                             success:(void (^)())success
                             failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] DELETE:[@"customers" stringByAppendingFormat:@"/%@", customerIdentifier] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success ();// TODO: shouldn't this be a 204?
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - Cards

+ (void)createCardWithIdentifier:(NSString *)customerIdentifier
                 tokenIdentifier:(NSString *)tokenIdentifier
                  shouldValidate:(BOOL)shouldValidate
                        metadata:(NSDictionary *)metadata
                         success:(void (^)(NSDictionary * _Nonnull))success
                         failure:(void (^)(NSError * _Nonnull))failure {
    
    NSDictionary *parameters = @{
                                 @"customer_id":customerIdentifier,
                                 @"token_id":tokenIdentifier,
                                 @"validate":@(shouldValidate),
                                 @"metadata":metadata
                                 };
    
    [[CLQHTTPSessionManager manager] POST:@"cards" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)getCardWithIdentifier:(NSString *)cardIdentifier
                      success:(void (^)(NSDictionary * _Nonnull))success
                      failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] GET:[@"cards" stringByAppendingFormat:@"/%@", cardIdentifier] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

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
                     success:(void (^)(NSDictionary * _Nonnull))success
                     failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (unixDate) [parameters setObject:unixDate forKey:@"date"];
    if (fromUnixDate) [parameters setObject:fromUnixDate forKey:@"date_from"];
    if (toUnixDate) [parameters setObject:toUnixDate forKey:@"date_to"];
    if (cardBrand) [parameters setObject:cardBrand forKey:@"card_brand"];
    if (cardType) [parameters setObject:cardType forKey:@"card_type"];
    if (deviceType) [parameters setObject:deviceType forKey:@"device_type"];
    if (bin) [parameters setObject:bin forKey:@"bin"];
    if (countryCode) [parameters setObject:countryCode forKey:@"country_code"];
    if (limit) [parameters setObject:limit forKey:@"limit"];
    if (beforeCustomerIdentifier) [parameters setObject:beforeCustomerIdentifier forKey:@"before"];
    if (afterCustomerIdentifier) [parameters setObject:afterCustomerIdentifier forKey:@"after"];
    
    [[CLQHTTPSessionManager manager] GET:@"cards" parameters:parameters.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)updateCardWithIdentifier:(NSString *)cardIdentifier
                        metadata:(NSDictionary *)metadata
                         success:(void (^)(NSDictionary * _Nonnull))success
                         failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] PATCH:[@"cards" stringByAppendingFormat:@"/%@", cardIdentifier] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)deleteCardWithIdentifier:(NSString *)cardIdentifier
                         success:(void (^)())success
                         failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] DELETE:[@"cards" stringByAppendingFormat:@"/%@", cardIdentifier] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success ();// TODO: shouldn't this be a 204?
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - Plans

+ (void)createPlanWithName:(NSString *)name
                    amount:(NSNumber *)amount
              currencyCode:(NSString *)currencyCode
                  interval:(NSString *)interval
             intervalCount:(NSNumber *)intervalCount
                 trialDays:(NSNumber *)trialDays
                     limit:(NSNumber *)limit
                  metadata:(NSDictionary *)metadata
                   success:(void (^)(NSDictionary * _Nonnull))success
                   failure:(void (^)(NSError * _Nonnull))failure {
    
    NSDictionary *parameters = @{
                                 @"name":name,
                                 @"amount":amount,
                                 @"currencyCode":currencyCode,
                                 @"interval":interval,
                                 @"intervalCount":intervalCount,
                                 @"trialDays":trialDays,
                                 @"limit":limit,
                                 @"metadata":metadata,
                                 };
    
    [[CLQHTTPSessionManager manager] POST:@"plans" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)getPlanWithIdentifier:(NSString *)planIdentifier
                      success:(void (^)(NSDictionary * _Nonnull))success
                      failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] GET:[@"plans" stringByAppendingFormat:@"/%@", planIdentifier] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)getPlansWithAmount:(NSNumber *)amount
                 minAmount:(NSNumber *)minAmount
                 maxAmount:(NSNumber *)maxAmount
              fromUnixDate:(NSNumber *)fromUnixDate
                toUnixDate:(NSNumber *)toUnixDate
                     limit:(NSNumber *)limit
      beforePlanIdentifier:(NSString *)beforePlanIdentifier
       afterPlanIdentifier:(NSString *)afterPlanIdentifier
                   success:(void (^)(NSDictionary * _Nonnull))success
                   failure:(void (^)(NSError * _Nonnull))failure {
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (amount) [parameters setObject:amount forKey:@"amount"];
    if (minAmount) [parameters setObject:minAmount forKey:@"min_amount"];
    if (maxAmount) [parameters setObject:maxAmount forKey:@"max_amount"];
    if (fromUnixDate) [parameters setObject:fromUnixDate forKey:@"date_from"];
    if (toUnixDate) [parameters setObject:toUnixDate forKey:@"date_to"];
    if (limit) [parameters setObject:limit forKey:@"limit"];
    if (beforePlanIdentifier) [parameters setObject:beforePlanIdentifier forKey:@"before"];
    if (afterPlanIdentifier) [parameters setObject:afterPlanIdentifier forKey:@"after"];
    
    [[CLQHTTPSessionManager manager] GET:@"plans" parameters:parameters.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)updatePlanWithIdentifier:(NSString *)planIdentifier
                        metadata:(NSDictionary *)metadata
                         success:(void (^)(NSDictionary * _Nonnull))success
                         failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] PATCH:[@"plans" stringByAppendingFormat:@"/%@", planIdentifier] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)deletePlanWithIdentifier:(NSString *)planIdentifier
                         success:(void (^)())success
                         failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] DELETE:[@"plans" stringByAppendingFormat:@"/%@", planIdentifier] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success ();// TODO: shouldn't this be a 204?
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - Subscriptions

+ (void)createSubscriptionWithCardIdentifier:(NSString *)cardIdentifier
                              planIdentifier:(NSString *)planIdentifier
                                    metadata:(NSDictionary *)metadata
                                     success:(void (^)(NSDictionary * _Nonnull))success
                                     failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:cardIdentifier forKey:@"card_id"];
    [parameters setObject:planIdentifier forKey:@"plan_id"];
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] POST:@"subscriptions" parameters:parameters.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)getSubscriptionWithIdentifier:(NSString *)subscriptionIdentifier
                              success:(void (^)(NSDictionary * _Nonnull))success
                              failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] GET:[@"subscriptions" stringByAppendingFormat:@"/%@", subscriptionIdentifier] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

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
                           success:(void (^)(NSDictionary * _Nonnull))success
                           failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (amount) [parameters setObject:amount forKey:@"amount"];
    if (minimumAmount) [parameters setObject:minimumAmount forKey:@"min_amount"];
    if (maximumAmount) [parameters setObject:maximumAmount forKey:@"max_amount"];
    if (unixDate) [parameters setObject:unixDate forKey:@"date"];
    if (fromUnixDate) [parameters setObject:fromUnixDate forKey:@"date_from"];
    if (toUnixDate) [parameters setObject:toUnixDate forKey:@"date_to"];
    if (interval) [parameters setObject:interval forKey:@"interval"];
    if (status) [parameters setObject:status forKey:@"status"];
    if (limit) [parameters setObject:limit forKey:@"limit"];
    if (beforeSubscriptionIdentifier) [parameters setObject:beforeSubscriptionIdentifier forKey:@"before"];
    if (afterSubscriptionIdentifier) [parameters setObject:afterSubscriptionIdentifier forKey:@"after"];
}

+ (void)updateSubscriptionWithIdentifier:(NSString *)subscriptionIdentifier
                                metadata:(NSDictionary *)metadata
                                 success:(void (^)(NSDictionary * _Nonnull))success
                                 failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] PATCH:[@"subscriptions" stringByAppendingFormat:@"/%@", subscriptionIdentifier] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)deleteSubscriptionWithIdentifier:(NSString *)subscriptionIdentifier
                                 success:(void (^)())success
                                 failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] DELETE:[@"subscriptions" stringByAppendingFormat:@"/%@", subscriptionIdentifier] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success ();// TODO: shouldn't this be a 204?
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - Helpers

+ (NSDictionary *)headersFromResponseTask:(NSURLSessionDataTask *)task {
    
    NSHTTPURLResponse *reponse = (NSHTTPURLResponse *)task.response;
    if ([reponse isKindOfClass:[NSHTTPURLResponse class]]) {
        return reponse.allHeaderFields;
    }else{
        return nil;
    }
}

@end
