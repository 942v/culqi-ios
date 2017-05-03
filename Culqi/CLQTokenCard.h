//
//  CLQTokenCard.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

NS_ASSUME_NONNULL_BEGIN
@interface CLQTokenCard : CLQBaseModelObject

@property (nonatomic, readonly) NSString *brand;
@property (nonatomic, readonly) NSString *number;
@property (nonatomic, readonly) NSString *bin;
@property (nonatomic, readonly) NSString *lastName;
@property (nonatomic, readonly) NSString *firstName;

- (instancetype)initWithBrand:(NSString *)brand
                       number:(NSString *)number
                          bin:(NSString *)bin
                     lastName:(NSString *)lastName
                    firstName:(NSString *)firstName;

+ (instancetype)newWithBrand:(NSString *)brand
                      number:(NSString *)number
                         bin:(NSString *)bin
                    lastName:(NSString *)lastName
                   firstName:(NSString *)firstName;

@end
NS_ASSUME_NONNULL_END
