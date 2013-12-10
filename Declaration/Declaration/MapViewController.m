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
#import "CarAnnotation.h"
#import "DirectionAnnotation.h"
@import MapKit;
@import AddressBookUI;

static NSString *DeleteIcon = @"❌";
static NSString *DirectionIcon = @"🎯";

@interface MapViewController ()
@property (nonatomic) UIPopoverController *annotationPopoverController;
@property (assign, nonatomic) CLLocationCoordinate2D lastTouchMapCoordinate;
@property (nonatomic) AnnotationTableViewController *annotationTableViewController;
@property (nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) MKAnnotationView *currentCarAnnotationView;
@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

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
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handleLongPress:)];
    [self.mapView addGestureRecognizer:gesture];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(handleTap:)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters & Setters

- (CLGeocoder *)geocoder
{
    return _geocoder ? _geocoder : (_geocoder = [[CLGeocoder alloc] init]);
}

- (AnnotationTableViewController *)annotationTableViewController
{
    if (_annotationTableViewController == nil) {
        UIStoryboard *storyboard = self.storyboard;
        _annotationTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"AnnotationTableViewController"];
        __weak typeof(self) weakSelf = self;
        _annotationTableViewController.tableViewDidSelect = ^(Car *car) {
            Car *carCopy = [car copy];
            [weakSelf.declaration addCarsObject:carCopy];
            
            CarAnnotation *annotation = [[CarAnnotation alloc] initWithCar:carCopy];
            annotation.coordinate = weakSelf.lastTouchMapCoordinate;
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
        //_annotationPopoverController.delegate = self;
    }
    return _annotationPopoverController;
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
}



- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[CarAnnotation class]]) {
        self.currentCarAnnotationView = view;
        
        CarAnnotation *annotation = view.annotation;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude
                                                          longitude:annotation.coordinate.longitude];
        [self.geocoder reverseGeocodeLocation:location
                            completionHandler:^(NSArray *placemarks, NSError *error) {
                                CLPlacemark *placemark = [placemarks firstObject];
                                annotation.subtitle = ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO);
                                annotation.car.geocoding = annotation.subtitle;
                            }];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView* annotationView = nil;
    if ([annotation isKindOfClass:[CarAnnotation class]]) {
        CarAnnotation *carAnnotation = annotation;
        UIImage *carImage = carAnnotation.car.image;
        if (carImage) {
            static NSString* CarAnnotationIdent = @"CarAnnotation";
            annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:CarAnnotationIdent];
            if (annotationView == nil) {
                annotationView = [[MKAnnotationView alloc] initWithAnnotation:carAnnotation
                                                              reuseIdentifier:CarAnnotationIdent];
                //annotationView.centerOffset = CGPointMake(0,0);
                annotationView.draggable = YES;
                annotationView.canShowCallout = YES;
                UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
                [deleteButton setTitle:DeleteIcon forState:UIControlStateNormal];
                deleteButton.frame = CGRectMake(0, 0, 23, 23);
                annotationView.rightCalloutAccessoryView = deleteButton;
                
                UIButton *directionButton = [UIButton buttonWithType:UIButtonTypeSystem];
                [directionButton setTitle:DirectionIcon forState:UIControlStateNormal];
                directionButton.frame = CGRectMake(0, 0, 23, 23);
                annotationView.leftCalloutAccessoryView = directionButton;
                
            }
            annotationView.image = carImage;
            annotationView.frame = CGRectMake(0, 0, carImage.size.width/3, carImage.size.height/3);
            annotationView.annotation = annotation;
        }
    } else if ([annotation isKindOfClass:[DirectionAnnotation class]]) {
        DirectionAnnotation *directionAnnotation = annotation;
        static NSString* DirectionAnnotationIdent = @"DirectionAnnotation";
        annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:DirectionAnnotationIdent];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:directionAnnotation
                                                          reuseIdentifier:DirectionAnnotationIdent];
            annotationView.image = [UIImage imageNamed:@"arrowhead"];
        }
        annotationView.transform = CGAffineTransformMakeRotation(directionAnnotation.car.angle);
        
    }
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateStarting) {
        CarAnnotation *annotation = self.currentCarAnnotationView.annotation;
        [self.mapView removeOverlay:annotation.directionAnnotation.directionLine];
        [self.mapView removeAnnotation:annotation.directionAnnotation];
    } else if (newState == MKAnnotationViewDragStateEnding
               || newState == MKAnnotationViewDragStateCanceling) {
        // custom code when drag ends...
        // tell the annotation view that the drag is done
        [annotationView setDragState:MKAnnotationViewDragStateNone animated:YES];
        CarAnnotation *annotation = self.currentCarAnnotationView.annotation;
        if (annotation.car.hasDirection) {            
            [annotation.directionAnnotation updateDirectionLine];
            [self.mapView addOverlay:annotation.directionAnnotation.directionLine];
            [self.mapView addAnnotation:annotation.directionAnnotation];
            self.currentCarAnnotationView.transform = CGAffineTransformMakeRotation(annotation.car.angle + 2 * M_2_PI);
        }
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[CarAnnotation class]]) {
        CarAnnotation *carAnnotation = view.annotation;
        //self.currentCarAnnotation = carAnnotation;
        if (control == view.leftCalloutAccessoryView) {
            [self.mapView addGestureRecognizer:self.tapGestureRecognizer];
            [mapView deselectAnnotation:carAnnotation animated:NO];
        } else if (control == view.rightCalloutAccessoryView) {
            [self.declaration removeCarsObject:carAnnotation.car];
            [self.mapView removeOverlay:carAnnotation.directionAnnotation.directionLine];
            [self.mapView removeAnnotation:carAnnotation.directionAnnotation];
            [mapView removeAnnotation:carAnnotation];
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.strokeColor = [UIColor blackColor];
        routeRenderer.lineWidth = 3.0;
        routeRenderer.alpha = 0.8;
        return routeRenderer;
    }
    return nil;
}


#pragma mark - Utils

- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    [self.mapView removeGestureRecognizer:self.tapGestureRecognizer];
    CGPoint touchPoint = [gesture locationInView:self.mapView];
    
    CarAnnotation *annotation = self.currentCarAnnotationView.annotation;
    
    [self.mapView removeOverlay:annotation.directionAnnotation.directionLine];
    [self.mapView removeAnnotation:annotation.directionAnnotation];
    
    annotation.directionAnnotation.coordinate = [self.mapView convertPoint:touchPoint
                                                      toCoordinateFromView:self.mapView];
    [self.mapView addOverlay:annotation.directionAnnotation.directionLine];
    [self.mapView addAnnotation:annotation.directionAnnotation];
    self.currentCarAnnotationView.transform = CGAffineTransformMakeRotation(annotation.car.angle + 2 * M_2_PI);
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gesture locationInView:self.mapView];
    self.lastTouchMapCoordinate = [self.mapView convertPoint:touchPoint
                                        toCoordinateFromView:self.mapView];
    [self.annotationPopoverController presentPopoverFromRect:CGRectMake(touchPoint.x, touchPoint.y, 1.0, 1.0)
                                                      inView:self.mapView
                                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                                    animated:YES];
}


//- (void)updateAnnotationForCar:(Car *)car
//{
//    CarAnnotation *annotation = self.currentCarAnnotationView.annotation;
//    
//    [self.mapView removeOverlay:annotation.directionLine];
//    [self.mapView removeAnnotation:annotation.directionAnnotation];
//    [annotation updateDirectionWithCoordinate:touchCoordinate];
//    [self.mapView addOverlay:annotation.directionLine];
//    [self.mapView addAnnotation:annotation.directionAnnotation];
//   
//}

/*
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
 */
@end
