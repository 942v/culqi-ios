//
//  Culqi.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLQResponseHeaders, CLQToken, CLQCard;

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
                          failure:(void (^_Nullable)(CLQResponseHeaders *_Nonnull responseHeaders, NSError * _Nonnull error))failure;

@end
