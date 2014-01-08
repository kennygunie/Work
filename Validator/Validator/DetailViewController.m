//
//  DetailViewController.m
//  Validator
//
//  Created by Kien Nguyen on 07/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "DetailViewController.h"
#import "Demande.h"
#import "CoreDataHelper.h"
#import "SyncEngine.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) Demande *demande;

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UISwitch *validedSwitch;

- (void)configureView;

- (IBAction)demandeValidSwitch:(id)sender;
- (IBAction)syncAction:(id)sender;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        self.demande = _detailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.demande) {
        //self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"subject"] description];
        self.subjectLabel.text = self.demande.subject;
        self.detailLabel.text = self.demande.detail;
        self.valueLabel.text = [NSString stringWithFormat:@"%.2f $", [self.demande.value floatValue]];
        self.validedSwitch.on = [self.demande.valid boolValue];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (!self.demande) {
        self.demande = [[CoreDataHelper sharedCoreDataHelper] getLastLocalDemande];
        [self configureView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - IBAction
- (IBAction)demandeValidSwitch:(id)sender
{
    BOOL state = [sender isOn];
    self.demande.valid = [NSNumber numberWithBool:state];
}

- (IBAction)syncAction:(id)sender
{
    [[SyncEngine sharedSyncEngine] getAllRemotesDemandesOnSuccess:^{
        [self configureView];
    } failure:nil];
}
@end
