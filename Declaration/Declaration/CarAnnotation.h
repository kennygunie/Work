//
//  CarAnnotation.h
//  Declaration
//
//  Created by Kien Nguyen on 26/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@class Car, DirectionAnnotation;

@interface CarAnnotation : NSObject <MKAnnotation>
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (nonatomic) Car *car;
@property (nonatomic) MKPolyline *direction;
@property (nonatomic) DirectionAnnotation *directionAnnotation;

- (instancetype)initWithCar:(Car *)car;
- (void)updateDirectionWithCoordinate:(CLLocationCoordinate2D)directionCoordinate;

@end
