//
//  CLQBaseModelObject.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLQBaseModelObject : NSObject <NSSecureCoding>

+ (NSString *)classNameString;

+ (instancetype)newWithData:(NSDictionary *)data;
+ (instancetype)new __unavailable;

+ (instancetype)initWithArchivedVersion:(NSData *)archivedVersion;

- (NSData *)getArchivedVersion;

@end
