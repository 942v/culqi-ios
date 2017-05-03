//
//  Culqi.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLQCard;
@class CLQToken;

NS_ASSUME_NONNULL_BEGIN
@interface Culqi : NSObject

@property (nonatomic, copy, readonly) NSString *merchantCode;

/**
 * gets singleton object.
 * @return singleton
 */
+ (Culqi *)sharedInstance;

- (void)setMerchantCode:(NSString *)merchantCode;

- (void)createTokenForCard:(CLQCard *)card
                   success:(void (^)(CLQToken *token))success
                   failure:(void (^)(NSError *error))failure;

@end
NS_ASSUME_NONNULL_END
