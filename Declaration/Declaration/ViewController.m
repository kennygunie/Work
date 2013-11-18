//
//  ViewController.m
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "FormViewController.h"
#import "PageViewController.h"
#import "MapViewController.h"

@import MapKit;

@interface ViewController ()

@property (weak, nonatomic) FormViewController *formViewController;
@property (weak, nonatomic) MapViewController *mapViewController;
@property (weak, nonatomic) PageViewController *pageViewController;
- (IBAction)confirmAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIView custom

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)confirmAction:(id)sender
{
    NSLog(@"title=%@", self.formViewController.titleTextField.text);
    NSLog(@"date=%@", self.formViewController.dateLabel.text);
    NSLog(@"description=%@", self.formViewController.descriptionTextView.text);
    CLLocationCoordinate2D userCoordinate = self.mapViewController.mapView.userLocation.location.coordinate;
    NSLog(@"latitude=%f longitude=%f", userCoordinate.latitude, userCoordinate.longitude);
}

#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FormViewController"]) {
        self.formViewController = [segue destinationViewController];
    } else if ([[segue identifier] isEqualToString:@"PageViewController"]) {
        self.pageViewController = [segue destinationViewController];
    } else if ([[segue identifier] isEqualToString:@"MapViewController"]) {
        self.mapViewController = [segue destinationViewController];
    }
}


@end
