//
//  ViewController.m
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "DeclarationViewController.h"
#import "FormViewController.h"
#import "PageViewController.h"
#import "MapViewController.h"
#import "UIImage+ImageEffects.h"
#import "Declaration.h"

@import MapKit;

@interface DeclarationViewController ()
@property (nonatomic) Declaration *declaration;
@property (nonatomic) FormViewController *formViewController;
@property (nonatomic) MapViewController *mapViewController;
@property (nonatomic) PageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@end

@implementation DeclarationViewController

- (Declaration *)declaration
{
    
    return _declaration ? _declaration : (_declaration = [[Declaration alloc] init]);
    
}

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
    [self.formViewController submitDeclaration];
    [self.declaration submit];
    
    /*
    NSLog(@"title=%@", self.formViewController.titleTextField.text);
    NSLog(@"date=%@", self.formViewController.dateLabel.text);
    NSLog(@"description=%@", self.formViewController.descriptionTextView.text);
    CLLocationCoordinate2D userCoordinate = self.mapViewController.mapView.userLocation.location.coordinate;
    NSLog(@"latitude=%f longitude=%f", userCoordinate.latitude, userCoordinate.longitude);
    */
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FormViewController"]) {
        self.formViewController = segue.destinationViewController;
        self.formViewController.declaration = self.declaration;
    } else if ([[segue identifier] isEqualToString:@"PageViewController"]) {
        self.pageViewController = segue.destinationViewController;
        __weak typeof(self) weakSelf = self;
        self.pageViewController.pageDidLoadImage = ^(UIImage *image) {
            weakSelf.backgroundImageView.image = [image applyExtraLightEffect];
        };
        self.pageViewController.declaration = self.declaration;
    } else if ([[segue identifier] isEqualToString:@"MapViewController"]) {
        self.mapViewController = segue.destinationViewController;
        self.mapViewController.declaration = self.declaration;
    }
}

@end
