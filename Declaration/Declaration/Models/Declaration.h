//
//  Declaration.h
//  Declaration
//
//  Created by Kien Nguyen on 21/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@class Car;

@interface Declaration : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *detail;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSMutableArray *photos; // of UIImage
@property (nonatomic) NSMutableSet *cars; // of Car

- (void)addPhotosObject:(UIImage *)photo;
- (void)addCarsObject:(Car *)car;
- (void)removeCarsObject:(Car *)car;
- (void)submit;
@end
