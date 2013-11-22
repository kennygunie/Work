//
//  Declaration.m
//  Declaration
//
//  Created by Kien Nguyen on 21/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "Declaration.h"
#import "NSDate+Utils.h"

@interface Declaration ()
@property (strong, nonatomic, readwrite) NSArray *photos;
@property (strong, nonatomic, readwrite) NSSet *cars;
@end

@implementation Declaration

#pragma mark - Getters & setters

- (NSDate *)date
{
    return _date? _date : (_date = [[NSDate alloc] init]);
}

#pragma mark - API

#pragma mark Photo
- (void)addPhotosObject:(UIImage *)photo
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    if ([_photos count] > 0) {
        [mutableArray addObjectsFromArray:_photos];
    }
    [mutableArray addObject:photo];
    _photos = mutableArray;
}

#pragma mark Car


- (void)addCarsObject:(Car *)car
{
    NSMutableSet *mutableSet = [[NSMutableSet alloc] init];
    if ([_cars count] > 0) {
        [mutableSet unionSet:_cars];
    }
    [mutableSet addObject:car];
    _cars = mutableSet;
}

- (void)removeCarsObject:(Car *)car
{
    if ([_cars count] > 0) {
        NSMutableSet *mutableSet = [[NSMutableSet alloc] initWithSet:_cars];
        [mutableSet removeObject:car];
        _cars = mutableSet;
    }
}

#pragma mark Declaration

- (void)submit
{
    NSLog(@"%@", self);
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"\nDeclaration {\n\tTitle: %@\n\tDescription: %@\n\tDate: %@\n\tPhotos count: %i\n\tLatitude: %f\n\tLongitude: %f\n}", self.title, self.detail, [self.date dateString], [self.photos count], self.currentLocation.latitude, self.currentLocation.longitude];
}

@end