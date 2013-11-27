//
//  Car.m
//  Declaration
//
//  Created by Kien Nguyen on 22/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "Car.h"

@interface Car ()
@property (strong, nonatomic, readwrite) UIImage *image;
@end

@implementation Car


- (instancetype)initWithCar:(Car *)car
{
    self = [super init];
    if (self) {
        self.model = car.model;
        self.image = car.image;
        self.imageName = car.imageName;
        self.coordinate = car.coordinate;
        self.geocoding = car.geocoding;
        self.angle = car.angle;
    }
    return self;
}

#pragma mark - Getters & Setters
- (UIImage *)image
{
    if (_image == nil && self.imageName.length > 0) {
        _image = [UIImage imageNamed:self.imageName];
    }
    return _image;
}

@end
