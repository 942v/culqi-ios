//
//  CLQOperation.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@interface CLQOperation : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSDate *creationDate;

@end
