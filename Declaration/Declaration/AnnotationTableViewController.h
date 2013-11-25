//
//  AnnotationTableViewController.h
//  Declaration
//
//  Created by Kien Nguyen on 25/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Car;

@interface AnnotationTableViewController : UITableViewController

@property (nonatomic, copy) void (^tableViewDidSelect)(Car *car);

@end
