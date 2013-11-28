//
//  ImageViewController.m
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *photoPickerButton;
@property (weak, nonatomic, readwrite) IBOutlet UIImageView *carImageView;
@end

@implementation PhotoViewController

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
    [self updateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters & setters

- (void)updateView;
{
    if (self.carImageView.image) {
        self.photoPickerButton.hidden = YES;
        self.carImageView.hidden = NO;
    } else {
        self.photoPickerButton.hidden = NO;
        self.carImageView.hidden = YES;
    }
}

#pragma mark - IBAction
- (IBAction)pickPhoto:(UIButton *)sender
{
    if (self.pickerDidSelected) {
        self.pickerDidSelected();
    }
}

- (void)setImage:(UIImage *)image
{
    self.carImageView.image = image;
    [self updateView];
}

@end
