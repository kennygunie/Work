//
//  Car.h
//  Declaration
//
//  Created by Kien Nguyen on 22/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface Car : NSObject <NSCopying>

@property (copy, nonatomic) NSString *model;
@property (copy, nonatomic) NSString *geocoding;
@property (nonatomic) UIImage *image;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) CLLocationCoordinate2D directionCoordinate;
@property (readonly) float angle;
@property (readonly) BOOL hasDirection;

//- (instancetype)initWithCar:(Car *)car;

@end
