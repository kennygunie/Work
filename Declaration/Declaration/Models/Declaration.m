//
//  Declaration.m
//  Declaration
//
//  Created by Kien Nguyen on 21/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "Declaration.h"
#import "NSDate+Utils.h"
#import "Car.h"

@implementation Declaration

#pragma mark - Getters & setters

- (NSDate *)date
{
    return _date? _date : (_date = [[NSDate alloc] init]);
}

#pragma mark - API

#pragma mark Photo
- (void)addPhotosObject:(UIImage *)photo
{
    if (_photos == nil) {
        _photos = [[NSMutableArray alloc] init];
    }
    [self.photos addObject:photo];
}

#pragma mark Car


- (void)addCarsObject:(Car *)car
{
    if (_cars == nil) {
        _cars = [[NSMutableSet alloc] init];
    }
    [self.cars addObject:car];
}

- (void)removeCarsObject:(Car *)car
{
    if ([_cars count] > 0) {
        [self.cars removeObject:car];
    }
}

#pragma mark Declaration

- (void)submit
{
    NSLog(@"%@", self);
}

- (NSString *)description
{
    NSMutableString *carsString =  [[NSMutableString alloc] init];
    for (Car *car in self.cars) {
        [carsString appendFormat:@"\n\t\t[%@]\n\t\tDirection %f %f\n%@", car.model, car.directionCoordinate.latitude, car.directionCoordinate.longitude, car.geocoding];
    }
    
    return [[NSString alloc] initWithFormat:@"\nDeclaration {\n\tTitle: %@\n\tDescription: %@\n\tDate: %@\n\tPhotos count: %i\n\tCars: %@\n}", self.title, self.detail, [self.date dateString], [self.photos count], carsString];
}

@end
