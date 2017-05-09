//
//  CLQCursors.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQCursors.h"

@implementation CLQCursors

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *afterIdentifier = [data objectForKey:@"after"];
    NSString *beforeIdentifier = [data objectForKey:@"before"];
    
    return [[CLQCursors alloc] initWithAfterIdentifier:afterIdentifier beforeIdentifier:beforeIdentifier];
}

- (instancetype)initWithAfterIdentifier:(NSString *)afterIdentifier beforeIdentifier:(NSString *)beforeIdentifier {
    
    self = [super init];
    if (self) {
        if ([afterIdentifier isKindOfClass:[NSString class]])_afterIdentifier = afterIdentifier;
        if ([beforeIdentifier isKindOfClass:[NSString class]])_beforeIdentifier = beforeIdentifier;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _afterIdentifier = [aDecoder decodeObjectOfClass:[self class] forKey:@"afterIdentifier"];
        _beforeIdentifier = [aDecoder decodeObjectOfClass:[self class] forKey:@"beforeIdentifier"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_afterIdentifier forKey:@"afterIdentifier"];
    [aCoder encodeObject:_beforeIdentifier forKey:@"beforeIdentifier"];
}

@end
