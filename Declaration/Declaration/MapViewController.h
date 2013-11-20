//
//  MapViewController.h
//  Declaration
//
//  Created by Kien NGUYEN on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKMapView;

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

//- (IBAction)dismissModalAction:(id)sender;
//- (IBAction)toggleStickerViewAction:(id)sender;

@end
