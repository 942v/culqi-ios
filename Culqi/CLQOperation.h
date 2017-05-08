//
//  CLQOperation.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

typedef enum : NSUInteger {
    CLQOperationTypeUnknown,
    CLQOperationTypeReturn,
    CLQOperationTypeDispute,
    CLQOperationTypeFraud
} CLQOperationType;

NS_ASSUME_NONNULL_BEGIN
@interface CLQOperation : CLQBaseModelObject

@property (nonatomic, assign, readonly) CLQOperationType type;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *creationDate;

@end

@interface CLQOperation (Helpers)

+ (NSString *)getOperationTypeKeyForEnum:(CLQOperationType)operationType;
+ (CLQOperationType)getOperationTypeEnumForKey:(NSString *)operationType;

@end
NS_ASSUME_NONNULL_END
