//
//  CLQCursors.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

NS_ASSUME_NONNULL_BEGIN
@interface CLQCursors : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *afterIdentifier;
@property (nonatomic, copy, readonly) NSString *beforeIdentifier;

@end
NS_ASSUME_NONNULL_END
