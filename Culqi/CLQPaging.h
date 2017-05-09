//
//  CLQPaging.h
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQBaseModelObject.h"

@class CLQCursors;

NS_ASSUME_NONNULL_BEGIN
@interface CLQPaging : CLQBaseModelObject

@property (nonatomic, copy, readonly) NSString *nextURLString;
@property (nonatomic, copy, readonly) NSString *previousURLString;
@property (nonatomic, strong, readonly) CLQCursors *cursors;

@end
NS_ASSUME_NONNULL_END
