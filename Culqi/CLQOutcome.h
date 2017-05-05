//
//  CLQOutcome.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/5/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@interface CLQOutcome : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *code;
@property (nonatomic, copy, readonly) NSString *declineCode;
@property (nonatomic, copy, readonly) NSString *merchantMessage;
@property (nonatomic, copy, readonly) NSString *userMessage;

@end
