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

#pragma mark - Getters & Setters
//- (UIImage *)image
//{
//    NSLog(@"%@ %@",self, self.imageName);
//    if (self.imageName.length == 0) {
//        return nil;
//    }
//    
//    if (_image == nil) {
//        _image = [UIImage imageNamed:self.imageName];
//    }
//    return _image;
//}

@end
