//
//  SlideViewController.m
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "PageViewController.h"
#import "PhotoViewController.h"

@interface PageViewController ()

@property (readonly, strong, nonatomic) NSArray *viewControllerArray;

@end

@implementation PageViewController

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
    
    self.dataSource = self;
    
    UIStoryboard *storyboard = self.storyboard;
    
    PhotoViewController *p1 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    p1.imageName = @"1";
    
    PhotoViewController *p2 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    p2.imageName = @"2";
    
    PhotoViewController *p3 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    p3.imageName = @"3";
    
    _viewControllerArray = @[p1, p2, p3];
    
    [self setViewControllers:@[p1]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllerArray indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self.viewControllerArray objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllerArray indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.viewControllerArray count]) {
        return nil;
    }
    return [self.viewControllerArray objectAtIndex:index];
}

@end
