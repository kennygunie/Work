//
//  AnnotationTableViewCell.m
//  Declaration
//
//  Created by Kien Nguyen on 26/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "AnnotationTableViewCell.h"

@implementation AnnotationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
