//
//  Car.m
//  Declaration
//
//  Created by Kien Nguyen on 22/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "Car.h"

@implementation Car


//- (instancetype)initWithCar:(Car *)car
//{
//    self = [super init];
//    if (self) {
//        self.model = car.model;
//        self.image = car.image;
//    }
//    return self;
//}


- (instancetype)copyWithZone:(NSZone *)zone
{
    Car *copy = [[[self class] allocWithZone:zone] init];
    if (copy) {
        copy.model = self.model;
        copy.image = self.image;
    }
    return copy;
}

- (float)angle
{
    return atan2l(self.coordinate.longitude - self.directionCoordinate.longitude, self.coordinate.latitude - self.directionCoordinate.latitude);
}

- (void)setDirectionCoordinate:(CLLocationCoordinate2D)directionCoordinate
{
    _hasDirection = YES;
    _directionCoordinate = directionCoordinate;
}

@end
