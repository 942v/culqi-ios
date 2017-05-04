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

+ (void)getTokenInfoWithIdentifier:(NSString *)identifier
                           success:(void (^)(NSDictionary * _Nonnull))success
                           failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] GET:[@"tokens" stringByAppendingFormat:@"/%@", identifier] parameters:NULL progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+ (void)updateTokenMetadataWithIdentifier:(NSString *)identifier
                                  success:(void (^)(NSDictionary * _Nonnull))success
                                  failure:(void (^)(NSError * _Nonnull))failure {
    
    [[CLQHTTPSessionManager manager] PATCH:[@"tokens" stringByAppendingFormat:@"/%@", identifier] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - Plans

+ (void)createPlanName:(NSString *)name
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
    
    [[CLQHTTPSessionManager manager] POST:@"plans" parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success (responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

@end
