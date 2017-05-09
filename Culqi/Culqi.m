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

@interface Culqi ()

@property (nonatomic, copy) NSString * _Nonnull apiKey;

@end

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

+ (void)setApiKey:(NSString *)apiKey {
    
    [Culqi sharedInstance].apiKey = apiKey;
    
    [CLQWebServices setAutorizationHeaderFieldWithApiKey:apiKey];
}

- (void)checkCredentials {
    
    NSAssert(self.apiKey, @"You need to set the API Key of Culqi first");
}

#pragma mark - Tokens

- (void)createTokenWithCardNumber:(NSString *)cardNumber
                              cvv:(NSString *)cvv
                  expirationMonth:(NSString *)expirationMonth
                   expirationYear:(NSString *)expirationYear
                            email:(NSString *)email
                         metadata:(NSDictionary * _Nullable)metadata
                          success:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQToken * _Nonnull))success
                          failure:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [self checkCredentials];
    
    [CLQWebServices createTokenWithCardNumber:cardNumber
                                          cvv:cvv
                              expirationMonth:expirationMonth
                               expirationYear:expirationYear
                                        email:email
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

- (void)getTokenWithIdentifier:(NSString *)tokenIdentifier
                       success:(void (^)(CLQResponseHeaders * _Nonnull, CLQToken * _Nonnull))success
                       failure:(void (^)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [self checkCredentials];
    
    [CLQWebServices getTokenWithIdentifier:tokenIdentifier
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

- (void)getTokensWithFromUnixDate:(NSNumber *)fromUnixDate
                       toUnixDate:(NSNumber *)toUnixDate
                        cardBrand:(NSString *)cardBrand
                         cardType:(CLQCardType)cardType
                       deviceType:(NSString *)deviceType
                              bin:(NSNumber *)bin
                      countryCode:(NSString *)countryCode
                            limit:(NSNumber *)limit
            beforeTokenIdentifier:(NSString *)beforeTokenIdentifier
             afterTokenIdentifier:(NSString *)afterTokenIdentifier
                          success:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQPaging * _Nonnull, NSArray<CLQToken *> * _Nonnull))success
                          failure:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [self checkCredentials];
    
    [CLQWebServices getTokensWithFromUnixDate:fromUnixDate
                                   toUnixDate:toUnixDate
                                    cardBrand:cardBrand
                                     cardType:[CLQIssuerIdentificationNumber getCardTypeKeyForEnum:cardType]
                                   deviceType:deviceType
                                          bin:bin
                                  countryCode:countryCode
                                        limit:limit
                        beforeTokenIdentifier:beforeTokenIdentifier
                         afterTokenIdentifier:afterTokenIdentifier
                                      success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQPaging * _Nonnull paging, NSArray<CLQToken *> * _Nonnull tokens) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              if (success) success(responseHeaders, paging, tokens);
                                          });
                                      }
                                      failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              if (failure) failure(responseHeaders, businessError, error);
                                          });
                                      }];
}

- (void)updateTokenWithIdentifier:(NSString *)tokenIdentifier
                         metadata:(NSDictionary *)metadata
                          success:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQToken * _Nonnull))success
                          failure:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [self checkCredentials];
    
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

#pragma mark - Charges

- (void)createChargeWithAmount:(NSNumber *)amount
                       capture:(BOOL)capture
                  currencyCode:(CLQCurrencyCodeType)currencyCode
                   description:(NSString *)description
                         email:(NSString *)email
                  installments:(NSNumber *)installments
              antifraudDetails:(CLQAntifraudDetails *)antifraudDetails
              sourceIdentifier:(NSString *)sourceIdentifier
                      metadata:(NSDictionary *)metadata
                       success:(void (^)(CLQResponseHeaders * _Nonnull, CLQCharge * _Nonnull))success
                       failure:(void (^)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [self checkCredentials];
    
    [CLQWebServices createChargeWithAmount:amount
                                   capture:@(capture)
                              currencyCode:[CLQCurrencyCode getCurrencyCodeTypeKeyForEnum:currencyCode]
                               description:description
                                     email:email
                              installments:installments
                          antifraudDetails:antifraudDetails
                          sourceIdentifier:sourceIdentifier
                                  metadata:metadata
                                   success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQCharge * _Nonnull charge) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           if (success) success(responseHeaders, charge);
                                       });
                                   }
                                   failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           if (failure) failure(responseHeaders, businessError, error);
                                       });
                                   }];
}

- (void)getChargeWithIdentifier:(NSString *)chargeIdentifier
                        success:(void (^)(CLQResponseHeaders * _Nonnull, CLQCharge * _Nonnull))success
                        failure:(void (^)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [self checkCredentials];
    
    [CLQWebServices getChargeWithIdentifier:chargeIdentifier
                                    success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQCharge * _Nonnull charge) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            if (success) success(responseHeaders, charge);
                                        });
                                    } failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            if (failure) failure(responseHeaders, businessError, error);
                                        });
                                    }];
}

- (void)getChargesWithAmount:(NSNumber *)amount
               minimumAmount:(NSNumber *)minimumAmount
               maximumAmount:(NSNumber *)maximumAmount
                installments:(NSNumber *)installments
         minimumInstallments:(NSNumber *)minimumInstallments
         maximumInstallments:(NSNumber *)maximumInstallments
            currencyCodeType:(CLQCurrencyCodeType)currencyCodeType
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
                    cardType:(CLQCardType)cardType
                  deviceType:(NSString *)deviceType
                         bin:(NSNumber *)bin
                       limit:(NSNumber *)limit
      beforeChargeIdentifier:(NSString *)beforeChargeIdentifier
       afterChargeIdentifier:(NSString *)afterChargeIdentifier
                     success:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQPaging * _Nonnull, NSArray<CLQCharge *> * _Nonnull))success
                     failure:(void (^)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [self checkCredentials];
    
    [CLQWebServices getChargesWithAmount:amount
                           minimumAmount:minimumAmount
                           maximumAmount:maximumAmount
                            installments:installments
                     minimumInstallments:minimumInstallments
                     maximumInstallments:maximumInstallments
                            currencyCode:[CLQCurrencyCode getCurrencyCodeTypeKeyForEnum:currencyCodeType]
                                    code:code
                            declinedCode:declinedCode
                              fraudScore:fraudScore
                       minimumFraudScore:minimumFraudScore
                       maximumFraudScore:maximumFraudScore
                               firstName:firstName
                                lastName:lastName
                                   email:email
                                 address:address
                             addressCity:addressCity
                             phoneNumber:phoneNumber
                             countryCode:countryCode
                                disputed:disputed
                                captured:captured
                              duplicated:duplicated
                                    paid:paid
                      customerIdentifier:customerIdentifier
                           referenceCode:referenceCode
                                unixDate:unixDate
                            fromUnixDate:fromUnixDate
                              toUnixDate:toUnixDate
                                     fee:fee
                              minimumFee:minimumFee
                              maximumFee:maximumFee
                               cardBrand:cardBrand
                                cardType:[CLQIssuerIdentificationNumber getCardTypeKeyForEnum:cardType]
                              deviceType:deviceType
                                     bin:bin
                                   limit:limit
                  beforeChargeIdentifier:beforeChargeIdentifier
                   afterChargeIdentifier:afterChargeIdentifier
                                 success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQPaging * _Nonnull paging, NSArray<CLQCharge *> * _Nonnull charges) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         if (success) success(responseHeaders, paging, charges);
                                     });
                                 } failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         if (failure) failure(responseHeaders, businessError, error);
                                     });
                                 }];
}

- (void)updateChargeWithIdentifier:(NSString *)chargeIdentifier
                          metadata:(NSDictionary *)metadata
                           success:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull, CLQCharge * _Nonnull))success
                           failure:(void (^)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [self checkCredentials];
    
    [CLQWebServices updateChargeWithIdentifier:chargeIdentifier
                                      metadata:metadata
                                       success:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQCharge * _Nonnull charge) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               if (success) success(responseHeaders, charge);
                                           });
                                       }
                                       failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               if (failure) failure(responseHeaders, businessError, error);
                                           });
                                       }];
}

- (void)deleteChargeWithIdentifier:(NSString *)chargeIdentifier
                           success:(void (^ _Nullable)(CLQResponseHeaders * _Nonnull))success
                           failure:(void (^)(CLQResponseHeaders * _Nonnull, CLQError * _Nonnull, NSError * _Nonnull))failure {
    
    [self checkCredentials];
    
    [CLQWebServices deleteChargeWithIdentifier:chargeIdentifier
                                       success:^(CLQResponseHeaders * _Nonnull responseHeaders) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               if (success) success(responseHeaders);
                                           });
                                       }
                                       failure:^(CLQResponseHeaders * _Nonnull responseHeaders, CLQError * _Nonnull businessError, NSError * _Nonnull error) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               if (failure) failure(responseHeaders, businessError, error);
                                           });
                                       }];
}

@end
