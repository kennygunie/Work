//
//  UITextView+Utils.m
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "UITextView+Utils.h"

@implementation UITextView (Utils)

- (void)setText:(NSString *)text color:(UIColor *)color
{
    self.text = text;
    self.textColor = color;
}

@end
