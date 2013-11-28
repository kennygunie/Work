//
//  Car.m
//  Declaration
//
//  Created by Kien Nguyen on 22/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "Car.h"

@implementation Car


- (instancetype)initWithCar:(Car *)car
{
    self = [super init];
    if (self) {
        self.model = car.model;
        self.image = car.image;
    }
    return self;
}

@end
