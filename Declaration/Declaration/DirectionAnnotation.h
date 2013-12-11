//
//  DirectionAnnotation.h
//  Declaration
//
//  Created by Kien Nguyen on 05/12/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@class Car, CarAnnotation;

@interface DirectionAnnotation : NSObject <MKAnnotation>
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) MKPolyline *directionLine;
@property (weak, nonatomic) CarAnnotation *carAnnotation;
@property (strong, nonatomic) Car *car;

- (void)updateDirectionLine;

@end
