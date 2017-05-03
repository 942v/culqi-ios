//
//  CLQTokenCard.m
//  Culqi
//
//  Created by Guillermo Sáenz on 5/2/17.
//  Copyright (c) 2017 Guillermo Sáenz. All rights reserved.
//

#import "CLQTokenCard.h"

@implementation CLQTokenCard

#pragma mark - Lifecycle

- (instancetype)initWithBrand:(NSString *)brand number:(NSString *)number bin:(NSString *)bin lastName:(NSString *)lastName firstName:(NSString *)firstName {
    
    self = [super init];
    if (self) {
        _brand = brand;
        _number = number;
        _bin = bin;
        _lastName = lastName;
        _firstName = firstName;
    }
    return self;
}

+ (instancetype)newWithBrand:(NSString *)brand number:(NSString *)number bin:(NSString *)bin lastName:(NSString *)lastName firstName:(NSString *)firstName {
    
    return [[CLQTokenCard alloc] initWithBrand:brand
                                        number:number
                                           bin:bin
                                      lastName:lastName
                                     firstName:firstName];
}

@end
