//
//  CLQPaging.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/9/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQPaging.h"

#import "CLQCursors.h"

@implementation CLQPaging

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *nextURLString = [data objectForKey:@"next"];
    NSString *previousURLString = [data objectForKey:@"previous"];
    NSDictionary *cursorsData = [data objectForKey:@"cursors"];
    
    return [[CLQPaging alloc] initWithNextURLString:nextURLString previousURLString:previousURLString cursorsData:cursorsData];
}

- (instancetype)initWithNextURLString:(NSString *)nextURLString previousURLString:(NSString *)previousURLString cursorsData:(NSDictionary *)cursorsData {
    
    self = [super init];
    if (self) {
        if ([nextURLString isKindOfClass:[NSString class]])_nextURLString = nextURLString;
        if ([previousURLString isKindOfClass:[NSString class]])_previousURLString = previousURLString;
        if ([cursorsData isKindOfClass:[NSDictionary class]])_cursors = [CLQCursors newWithData:cursorsData];
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _nextURLString = [aDecoder decodeObjectOfClass:[self class] forKey:@"nextURLString"];
        _previousURLString = [aDecoder decodeObjectOfClass:[self class] forKey:@"previousURLString"];
        _cursors = [aDecoder decodeObjectOfClass:[self class] forKey:@"cursors"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_nextURLString forKey:@"nextURLString"];
    [aCoder encodeObject:_previousURLString forKey:@"previousURLString"];
    [aCoder encodeObject:_cursors forKey:@"cursors"];
}

@end
