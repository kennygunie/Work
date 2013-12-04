//
//  UIBezierPath+Utils.h
//  Declaration
//
//  Created by Kien Nguyen on 04/12/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 https://gist.github.com/mayoff/4146780
 UIBezierPath+dqd_arrowhead
 */
@interface UIBezierPath (Utils)

+ (UIBezierPath *)bezierPathWithArrowFromPoint:(CGPoint)startPoint
                                       toPoint:(CGPoint)endPoint
                                     tailWidth:(CGFloat)tailWidth
                                     headWidth:(CGFloat)headWidth
                                    headLength:(CGFloat)headLength;

@end
