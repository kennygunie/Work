//
//  ViewController.m
//  TwoTableView
//
//  Created by Kien Nguyen on 15/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "FirstTableViewController.h"
#import "SecondTableViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self firstTableViewController];
    [self secondTableViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters & setters

- (FirstTableViewController *)firstTableViewController
{
    if (_firstTableViewController == nil) {
        _firstTableViewController = [[FirstTableViewController alloc] init];
        _firstTableViewController.tableView = self.firstTableView;
    }
    return _firstTableViewController;
}

- (SecondTableViewController *)secondTableViewController
{
    if (_secondTableViewController == nil) {
        _secondTableViewController = [[SecondTableViewController alloc] init];
        _secondTableViewController.tableView = self.secondTableView;
    }
    return _secondTableViewController;
}

@end
