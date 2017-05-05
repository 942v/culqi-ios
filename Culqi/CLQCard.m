//
//  CLQCard.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQCard.h"

#import "CLQToken.h"
#import "CLQClient.h"

@implementation CLQCard

+ (instancetype)newWithData:(NSDictionary *)data {
    
    NSString *object = [data objectForKey:@"object"];
    NSString *identifier = [data objectForKey:@"id"];
    NSNumber *date = [data objectForKey:@"date"];
    NSString *customerIdentifier = [data objectForKey:@"customer_id"];
    NSDictionary *tokenSourceData = [data objectForKey:@"source"];
    NSDictionary *clientData = [data objectForKey:@"client"];
    NSDictionary *metadata = [data objectForKey:@"metadata"];
    
    return [[CLQCard alloc] initWithObject:object identifier:identifier date:date customerIdentifier:customerIdentifier tokenSourceData:tokenSourceData clientData:clientData metadata:metadata];
}

- (instancetype)initWithObject:(NSString *)object identifier:(NSString *)identifier date:(NSNumber *)date customerIdentifier:(NSString *)customerIdentifier tokenSourceData:(NSDictionary *)tokenSourceData clientData:(NSDictionary *)clientData metadata:(NSDictionary *)metadata {
    
    self = [super init];
    if (self) {
        if ([object isKindOfClass:[NSString class]])_object = object;
        if ([identifier isKindOfClass:[NSString class]])_identifier = identifier;
        if ([date isKindOfClass:[NSNumber class]])_date = [NSDate dateWithTimeIntervalSince1970:date.doubleValue];
        if ([customerIdentifier isKindOfClass:[NSString class]])_customerIdentifier = customerIdentifier;
        if ([tokenSourceData isKindOfClass:[NSDictionary class]])_tokenSource = [CLQToken newWithData:tokenSourceData];
        if ([clientData isKindOfClass:[NSDictionary class]])_client = [CLQClient newWithData:clientData];
        if ([metadata isKindOfClass:[NSDictionary class]])_metadata = metadata;
    }
    return self;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _object = [aDecoder decodeObjectOfClass:[self class] forKey:@"object"];
        _identifier = [aDecoder decodeObjectOfClass:[self class] forKey:@"identifier"];
        _date = [aDecoder decodeObjectOfClass:[self class] forKey:@"date"];
        _customerIdentifier = [aDecoder decodeObjectOfClass:[self class] forKey:@"customerIdentifier"];
        _tokenSource = [aDecoder decodeObjectOfClass:[self class] forKey:@"tokenSource"];
        _client = [aDecoder decodeObjectOfClass:[self class] forKey:@"client"];
        _metadata = [aDecoder decodeObjectOfClass:[self class] forKey:@"metadata"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_object forKey:@"object"];
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_customerIdentifier forKey:@"customerIdentifier"];
    [aCoder encodeObject:_tokenSource forKey:@"tokenSource"];
    [aCoder encodeObject:_client forKey:@"client"];
    [aCoder encodeObject:_metadata forKey:@"metadata"];
}

@end
