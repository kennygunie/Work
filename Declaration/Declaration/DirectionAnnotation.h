//
//  DirectionAnnotation.h
//  Declaration
//
//  Created by Kien Nguyen on 05/12/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface DirectionAnnotation : NSObject <MKAnnotation>
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property float angle;
@property (readonly, nonatomic) UIImage *directionImage;

- (instancetype)initWithAngle:(float)angle;

@end
