//
//  ViewController.m
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "FormViewController.h"
@interface ViewController ()

@property (weak, nonatomic) FormViewController *formViewController;

- (IBAction)confirmAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *viewControllerArray = [self childViewControllers];
    for (UIViewController *vc in viewControllerArray) {
        if ([vc isKindOfClass:[FormViewController class]]) {
            self.formViewController = (FormViewController *)vc;
        }
    }
    
    
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
    NSLog(@"%@", self.formViewController.titleTextField.text);
}
@end
