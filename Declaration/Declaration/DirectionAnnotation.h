//
//  DirectionAnnotation.h
//  Declaration
//
//  Created by Kien Nguyen on 05/12/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@class Car;

@interface DirectionAnnotation : NSObject <MKAnnotation>
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
//@property (copy, nonatomic) NSString *title;
//@property (copy, nonatomic) NSString *subtitle;
@property (strong, nonatomic) Car *car;
@property (nonatomic) MKPolyline *directionLine;

- (instancetype)initWithCar:(Car *)car;
- (void)updateDirectionLine;

@end
