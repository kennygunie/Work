//
//  Car.h
//  Declaration
//
//  Created by Kien Nguyen on 22/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface Car : NSObject

@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic, readonly) UIImage *image;
@property (nonatomic) CLLocationCoordinate2D location;
@property float angle;


@end
