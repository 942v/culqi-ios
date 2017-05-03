//
//  CLQCard.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

NS_ASSUME_NONNULL_BEGIN
@interface CLQCard : CLQBaseModelObject

@property (nonatomic, readonly) NSNumber *number;
@property (nonatomic, readonly) NSNumber *cvc;
@property (nonatomic, readonly) NSNumber *expMonth;
@property (nonatomic, readonly) NSNumber *expYear;
@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;
@property (nonatomic, readonly) NSString *email;

- (instancetype)initWithNumber:(NSNumber *)number
                           CVC:(NSNumber *)cvc
                      expMonth:(NSNumber *)expMonth
                       expYear:(NSNumber *)expYear
                     firstName:(NSString *)firstName
                      lastName:(NSString *)lastName
                         email:(NSString *)email;

+ (instancetype)newWithNumber:(NSNumber *)number
                          CVC:(NSNumber *)cvc
                     expMonth:(NSNumber *)expMonth
                      expYear:(NSNumber *)expYear
                    firstName:(NSString *)firstName
                     lastName:(NSString *)lastName
                        email:(NSString *)email;

- (void)drive;

@end
NS_ASSUME_NONNULL_END
