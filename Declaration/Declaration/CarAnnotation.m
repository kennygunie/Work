//
//  CarAnnotation.m
//  Declaration
//
//  Created by Kien Nguyen on 26/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "CarAnnotation.h"
#import "Car.h"
#import "DirectionAnnotation.h"

@implementation CarAnnotation

- (instancetype)initWithCar:(Car *)car
{
    self = [super init];
    if (self) {
        self.car = car;
        self.title = car.model;
        self.subtitle = car.geocoding;
        self.coordinate = car.coordinate;
    }
    return self;
}

#pragma mark - Getters & setters
- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    _coordinate = coordinate;
    _car.coordinate = coordinate;
}

- (DirectionAnnotation *)directionAnnotation
{
    if (_directionAnnotation == nil && _car) {
        _directionAnnotation = [[DirectionAnnotation alloc] initWithCar:self.car];

    }
    return _directionAnnotation;
}

@end
