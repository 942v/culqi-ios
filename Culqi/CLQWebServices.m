//
//  CLQWebServices.m
//  Culqi
//
//  Created by Guillermo Sáenz on 9/18/16.
//  Copyright (c) 2016 Guillermo Sáenz. All rights reserved.
//

#import "CLQWebServices.h"

#import "CLQHTTPSessionManager.h"

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
                         metadata:(NSDictionary *)metadata
                          success:(void (^)(NSDictionary * _Nonnull))success
                          failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (cardNumber) [parameters setObject:cardNumber forKey:@"card_number"];
    if (cvv) [parameters setObject:cvv forKey:@"cvv"];
    if (expirationMonth) [parameters setObject:expirationMonth forKey:@"expiration_month"];
    if (expirationYear) [parameters setObject:expirationYear forKey:@"expiration_year"];
    if (email) [parameters setObject:email forKey:@"email"];
    if (metadata) [parameters setObject:metadata forKey:@"metadata"];
    
    [[CLQHTTPSessionManager manager] POST:@"tokens" parameters:parameters.copy progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
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

#pragma mark - Charges

#pragma mark - Subscriptions

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
                 success:(void (^)(NSDictionary * _Nonnull))success
                 failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (date) [parameters setObject:date forKey:@"date"];
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

@end
