//
//  MapViewController.h
//  Declaration
//
//  Created by Kien NGUYEN on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKMapView, Declaration;

@interface MapViewController : UIViewController <UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) Declaration *declaration;
@end
