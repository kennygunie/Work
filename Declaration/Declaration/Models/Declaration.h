//
//  Declaration.h
//  Declaration
//
//  Created by Kien Nguyen on 21/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface Declaration : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSMutableArray *photos;
@property (nonatomic) CLLocationCoordinate2D currentLocation;

- (void)addPhoto:(UIImage *)photo;
- (void)submit;
@end
