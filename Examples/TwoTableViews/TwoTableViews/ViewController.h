//
//  ViewController.h
//  TwoTableView
//
//  Created by Kien Nguyen on 15/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstTableViewController;
@class SecondTableViewController;

@interface ViewController : UIViewController

@property (strong, nonatomic) FirstTableViewController *firstTableViewController;
@property (strong, nonatomic) SecondTableViewController *secondTableViewController;

@end
