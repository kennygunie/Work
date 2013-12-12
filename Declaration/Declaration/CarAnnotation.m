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
//@synthesize directionAnnotation = _directionAnnotation;

#pragma mark - Getters & setters

- (void)setCar:(Car *)car
{
    _car = car;
    self.title = car.model;
    self.subtitle = car.geocoding;
    self.coordinate = car.coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    _coordinate = coordinate;
    _car.coordinate = coordinate;
}

- (DirectionAnnotation *)directionAnnotation
{
    if (_directionAnnotation == nil) {
        _directionAnnotation = [[DirectionAnnotation alloc] init];
        _directionAnnotation.car = self.car;
        _directionAnnotation.carAnnotation = self;
    }
    return _directionAnnotation;
}

@end
