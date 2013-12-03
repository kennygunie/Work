//
//  CarAnnotation.m
//  Declaration
//
//  Created by Kien Nguyen on 26/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "CarAnnotation.h"
#import "Car.h"

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
- (void)coordinate:(CLLocationCoordinate2D)coordinate
{
    _coordinate = coordinate;
    self.car.coordinate = coordinate;
}

- (void)updateDirectionWithCoordinate:(CLLocationCoordinate2D)directionCoordinate
{
    self.car.directionCoordinate = directionCoordinate;
    
    CLLocationCoordinate2D coordinateArray[2] = {self.car.coordinate, self.car.directionCoordinate};
    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinateArray
                                                         count:2];
    free(coordinateArray);
    self.direction = polyLine;
}

@end
