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

#pragma mark - Getters & Setters
- (UIImage *)image
{
    return _image ? _image : (_image = [UIImage imageNamed:self.imageName]);
}

@end
