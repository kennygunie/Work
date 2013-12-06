//
//  DirectionAnnotation.m
//  Declaration
//
//  Created by Kien Nguyen on 05/12/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "DirectionAnnotation.h"

@implementation DirectionAnnotation

- (instancetype)initWithAngle:(float)angle
{
    self = [super init];
    if (self) {
        _angle = angle;
        _directionImage = [UIImage imageNamed:@"triangle"];
    }
    return self;
}

@end
