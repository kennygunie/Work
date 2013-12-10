//
//  DirectionAnnotation.m
//  Declaration
//
//  Created by Kien Nguyen on 05/12/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "DirectionAnnotation.h"
#import "Car.h"

@implementation DirectionAnnotation

- (instancetype)initWithCar:(Car *)car
{
    self = [super init];
    if (self) {
        _car = car;
        _coordinate = car.directionCoordinate;
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    _coordinate = coordinate;
    self.car.directionCoordinate = coordinate;
    [self updateDirectionLine];
}

- (void)updateDirectionLine
{
    CLLocationCoordinate2D coordinateArray[2] = {self.car.coordinate, self.car.directionCoordinate};
    self.directionLine = [MKPolyline polylineWithCoordinates:coordinateArray
                                                       count:2];
}

@end
