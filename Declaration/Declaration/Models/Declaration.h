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
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic, readonly) NSArray *photos; // of UIImage
@property (strong, nonatomic, readonly) NSSet *cars; // of Car

- (void)addPhotosObject:(UIImage *)photo;
- (void)addCarsObject:(Car *)car;
- (void)removeCarsObject:(Car *)car;
- (void)submit;
@end
