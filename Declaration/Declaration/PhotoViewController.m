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
    if (self.imageName.length > 0) {
        [self.carImageView setImage:[UIImage imageNamed:self.imageName]];
    } else {
        self.photoPickerButton.hidden = NO;
        self.carImageView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickPhoto:(UIButton *)sender
{
    
}



@end
