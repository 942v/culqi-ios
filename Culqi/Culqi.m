//
//  Culqi.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "Culqi.h"

#import "CLQHTTPSessionManager.h"

#import "CLQWebServices.h"

#import "CLQCard.h"
#import "CLQToken.h"

@implementation Culqi

static NSString *CLQCheckoutBaseURLString = @"https://api.culqi.com/v2/";

static Culqi *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copy {
    return [[Culqi alloc] init];
}

- (id)mutableCopy {
    return [[Culqi alloc] init];
}

- (id) init {
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    if (self) {
        [CLQHTTPSessionManager initWithBaseURLString:CLQCheckoutBaseURLString];
    }
    return self;
}

#pragma mark - Autorization

- (void)setMerchantCode:(NSString *)merchantCode {
    
    [CLQWebServices setAutorizationHeaderFieldWithMerchantCode:merchantCode];
    
    _merchantCode = merchantCode;
}

#pragma mark - Tokenization

- (void)createTokenWithCardNumber:(NSString *)cardNumber
                              cvv:(NSString *)cvv
                  expirationMonth:(NSString *)expirationMonth
                   expirationYear:(NSString *)expirationYear
                            email:(NSString *)email
                         metadata:(NSDictionary * _Nullable)metadata
                          success:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQToken * _Nonnull))success
                          failure:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [CLQWebServices createTokenWithCardNumber:cardNumber cvv:cvv expirationMonth:expirationMonth expirationYear:expirationYear email:email metadata:metadata success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQToken * _Nonnull token) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) success(responseHeaders, token);
        });
    } failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) failure(responseHeaders, businessError, error);
        });
    }];
}

- (void)getTokenWithIdentifier:(NSString *)tokenIdentifier
                       success:(void (^)(CLQResponseHeaders * _Nonnull, CLQToken * _Nonnull))success
                       failure:(void (^)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [CLQWebServices getTokenWithIdentifier:tokenIdentifier success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQToken * _Nonnull token) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) success(responseHeaders, token);
        });
    } failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) failure(responseHeaders, businessError, error);
        });
    }];
}

- (void)getTokensWithFromUnixDate:(NSNumber *)fromUnixDate
                       toUnixDate:(NSNumber *)toUnixDate
                        cardBrand:(NSString *)cardBrand
                         cardType:(NSString *)cardType
                       deviceType:(NSString *)deviceType
                              bin:(NSNumber *)bin
                      countryCode:(NSString *)countryCode
                            limit:(NSNumber *)limit
            beforeTokenIdentifier:(NSString *)beforeTokenIdentifier
             afterTokenIdentifier:(NSString *)afterTokenIdentifier
                          success:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQPaging * _Nonnull, NSArray<CLQToken *> * _Nonnull))success
                          failure:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [CLQWebServices getTokensWithFromUnixDate:fromUnixDate toUnixDate:toUnixDate cardBrand:cardBrand cardType:cardType deviceType:deviceType bin:bin countryCode:countryCode limit:limit beforeTokenIdentifier:beforeTokenIdentifier afterTokenIdentifier:afterTokenIdentifier success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQPaging * _Nonnull paging, NSArray<CLQToken *> * _Nonnull tokens) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) success(responseHeaders, paging, tokens);
        });
    } failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) failure(responseHeaders, businessError, error);
        });
    }];
}

- (void)updateTokenWithIdentifier:(NSString *)tokenIdentifier
                         metadata:(NSDictionary *)metadata
                          success:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQToken * _Nonnull))success
                          failure:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [CLQWebServices updateTokenWithIdentifier:tokenIdentifier
                                     metadata:metadata
                                      success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQToken * _Nonnull token) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              if (success) success(responseHeaders, token);
                                          });
                                      }
                                      failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              if (failure) failure(responseHeaders, businessError, error);
                                          });
                                      }];
}

@end
