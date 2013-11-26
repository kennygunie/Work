//
//  MapViewController.m
//  Declaration
//
//  Created by Kien NGUYEN on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "MapViewController.h"
#import "Declaration.h"
#import "AnnotationTableViewController.h"
#import "Car.h"
@import MapKit;

@interface MapViewController ()
@property (strong, nonatomic) UIPopoverController *annotationPopoverController;
//@property (strong, nonatomic) MKPointAnnotation *currentAnnotation;
@property (assign, nonatomic) CLLocationCoordinate2D lastTouchMapCoordinate;
@property (strong, nonatomic) AnnotationTableViewController *annotationTableViewController;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
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

#pragma mark - Getters & Setters


- (AnnotationTableViewController *)annotationTableViewController
{
    if (_annotationTableViewController == nil) {
        UIStoryboard *storyboard = self.storyboard;
        _annotationTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"AnnotationTableViewController"];
        __weak typeof(self) weakSelf = self;
        _annotationTableViewController.tableViewDidSelect = ^(Car *car) {
            car.coordinate = weakSelf.lastTouchMapCoordinate;
            NSLog(@"%@ lat=%f lng=%f", car.model, car.coordinate.latitude, car.coordinate.longitude);
            [weakSelf.declaration addCarsObject:car];
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = car.coordinate;
            annotation.subtitle = car.imageName;
            [weakSelf.mapView addAnnotation:annotation];
            [weakSelf.annotationPopoverController dismissPopoverAnimated:YES];
            
        };
    }
    
    return _annotationTableViewController;
}

- (UIPopoverController *)annotationPopoverController
{
    if (_annotationPopoverController == nil) {
        _annotationPopoverController = [[UIPopoverController alloc] initWithContentViewController:self.annotationTableViewController];
        _annotationPopoverController.delegate = self;
    }
    return _annotationPopoverController;
}

#pragma mark - UIPopoverControllerDelegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    //    if (self.currentAnnotation.title.length == 0) {
    //        [self.mapView removeAnnotation:self.currentAnnotation];
    //    }
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
    self.declaration.currentCoordinate = location;
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


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView* annotationView = nil;
    if (annotation.subtitle.length > 0) {
        static NSString* ident = @"carPin";
        annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ident];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:ident];
            annotationView.image = [UIImage imageNamed:annotation.subtitle]; // subtitle = car image name
            CGRect f = annotationView.bounds;
            f.size.height /= 3.0;
            f.size.width /= 3.0;
            annotationView.bounds = f;
            annotationView.centerOffset = CGPointMake(0,-20);
            annotationView.canShowCallout = YES;
        }
        annotationView.annotation = annotation;
    }
    return annotationView;
}

#pragma mark - Utils

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state != UIGestureRecognizerStateBegan) return;
    
    CGPoint touchPoint = [gesture locationInView:self.mapView];
    self.lastTouchMapCoordinate = [self.mapView convertPoint:touchPoint
                                        toCoordinateFromView:self.mapView];
    
    [self.annotationPopoverController presentPopoverFromRect:CGRectMake(touchPoint.x, touchPoint.y, 1.0, 1.0)
                                                      inView:self.mapView
                                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                                    animated:YES];
    
    
    
    //add pin where user touched down...
    //self.currentAnnotation = [[MKPointAnnotation alloc] init];
    //self.currentAnnotation.coordinate = touchMapCoordinate;
    //[self.mapView addAnnotation:self.currentAnnotation];
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
