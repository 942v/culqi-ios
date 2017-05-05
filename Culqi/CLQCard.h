//
//  CLQCard.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@class CLQToken, CLQClient;

NS_ASSUME_NONNULL_BEGIN
@interface CLQCard : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *object;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *date;
@property (nonatomic, copy, readonly) NSString *customerIdentifier;
@property (nonatomic, strong, readonly) CLQToken *tokenSource;
@property (nonatomic, strong, readonly) CLQClient *client;
@property (nonatomic, strong, readonly) NSDictionary *metadata;

@end
NS_ASSUME_NONNULL_END
