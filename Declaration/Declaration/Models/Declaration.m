//
//  Declaration.m
//  Declaration
//
//  Created by Kien Nguyen on 21/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "Declaration.h"
#import "NSDate+Utils.h"

@implementation Declaration

#pragma mark - Getters & setters

- (NSDate *)date
{
    if (_date == nil) {
        _date = [[NSDate alloc] init];
    }
    return _date;
}

- (NSMutableArray *)photos
{
    if (_photos == nil) {
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}


#pragma mark - API


- (void)addPhoto:(UIImage *)photo
{
    [self.photos addObject:photo];
}

- (void)submit
{
    NSLog(@"%@", self);
}

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"\nDeclaration {\n\tTitle: %@\n\tDescription: %@\n\tDate: %@\n\tPhotos count: %i\n\tLatitude: %f\n\tLongitude: %f\n}", self.title, self.detail, [self.date dateString], [self.photos count], self.currentLocation.latitude, self.currentLocation.longitude];
}

@end
