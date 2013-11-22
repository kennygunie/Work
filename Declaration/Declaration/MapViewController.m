//
//  MapViewController.m
//  Declaration
//
//  Created by Kien NGUYEN on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "MapViewController.h"
#import "Declaration.h"
@import MapKit;

@interface MapViewController ()
@property (strong, nonatomic) NSArray *imageArray; // of UIImage
@property (weak, nonatomic) IBOutlet UIImageView *car1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *car2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *car3ImageView;
@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self addPanGestureToViews:@[self.car1ImageView, self.car2ImageView, self.car3ImageView]];
    //[self addRotationGestureToViews:@[self.car1ImageView, self.car2ImageView, self.car3ImageView]];
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handleLongPress:)];
    [self.mapView addGestureRecognizer:gesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapView delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.0005;
    span.longitudeDelta = 0.0005;
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
    self.declaration.currentLocation = location;
}

/*
#pragma mark - IBAction
 - (IBAction)dismissModalAction:(id)sender
 {
 [self dismissViewControllerAnimated:YES completion:nil];
 }
 
 - (IBAction)toggleStickerViewAction:(id)sender
 {
 if (self.stickerView.hidden) {
 [self.toggleStickerButton setTitle:NSLocalizedString(@"Reset", nil)
 forState:UIControlStateNormal];
 } else {
 [self.toggleStickerButton setTitle:NSLocalizedString(@"Add stikers", nil)
 forState:UIControlStateNormal];
 }
 self.stickerView.hidden = !self.stickerView.hidden;
 
 }
 */

#pragma mark - Utils

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    
}

- (void)addRotationGestureToViews:(NSArray *)viewArray
{
    for (UIView *view in viewArray) {
        UIRotationGestureRecognizer *gestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                      action:@selector(handleRotation:)];
        [view addGestureRecognizer:gestureRecognizer];
    }
}

- (void)handleRotation:(UIRotationGestureRecognizer *)gesture
{
    gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, gesture.rotation);
    gesture.rotation = 0;
}

- (void)addPanGestureToViews:(NSArray *)viewArray
{
    for (UIView *view in viewArray) {
        UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handlePan:)];
        [view addGestureRecognizer:gestureRecognizer];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    gesture.view.center = [gesture locationInView:gesture.view.superview];
}
@end
