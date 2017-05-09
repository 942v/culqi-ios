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

@interface Culqi : NSObject

@property (nonatomic, copy, readonly) NSString * _Nonnull merchantCode;

/**
 * gets singleton object.
 * @return singleton
 */
+ (Culqi *_Nonnull)sharedInstance;

- (void)setMerchantCode:(NSString *_Nonnull)merchantCode;

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

/**
 You can search tokens
 
 @warning Admin mode only
 @warning Use with your secret key

 @param fromUnixDate <#fromUnixDate description#>
 @param toUnixDate <#toUnixDate description#>
 @param cardBrand <#cardBrand description#>
 @param cardType <#cardType description#>
 @param deviceType <#deviceType description#>
 @param bin <#bin description#>
 @param countryCode <#countryCode description#>
 @param limit <#limit description#>
 @param beforeTokenIdentifier <#beforeTokenIdentifier description#>
 @param afterTokenIdentifier <#afterTokenIdentifier description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)getTokensWithFromUnixDate:(NSNumber*_Nullable)fromUnixDate
                       toUnixDate:(NSNumber*_Nullable)toUnixDate
                        cardBrand:(NSString*_Nullable)cardBrand
                         cardType:(NSString*_Nullable)cardType
                       deviceType:(NSString*_Nullable)deviceType
                              bin:(NSNumber*_Nullable)bin
                      countryCode:(NSString*_Nullable)countryCode
                            limit:(NSNumber*_Nullable)limit
            beforeTokenIdentifier:(NSString*_Nullable)beforeTokenIdentifier
             afterTokenIdentifier:(NSString*_Nullable)afterTokenIdentifier
                          success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQPaging *_Nonnull paging, NSArray <CLQToken *> *_Nonnull tokens))success
                          failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;


/**
 <#Description#>
 
 @warning Admin mode only
 @warning Use with your secret key

 @param tokenIdentifier <#tokenIdentifier description#>
 @param metadata <#metadata description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)updateTokenWithIdentifier:(NSString *_Nonnull)tokenIdentifier
                         metadata:(NSDictionary *_Nonnull)metadata
                          success:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQToken *_Nonnull token))success
                         failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, CLQError *_Nonnull businessError, NSError *_Nonnull error))failure;

@end
