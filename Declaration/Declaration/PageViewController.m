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
@property NSUInteger currentIndex;
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
    self.delegate = self;
    
    UIStoryboard *storyboard = self.storyboard;
    
    PhotoViewController *p1 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    p1.imageName = @"a1";
    
    PhotoViewController *p2 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    p2.imageName = @"a2";
    
    PhotoViewController *p3 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    p3.imageName = @"a3";
    
    _viewControllerArray = @[p1, p2, p3];
    
    __weak typeof(self) weakSelf = self;
    
    [self setViewControllers:@[p1]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:^(BOOL finished) {
                      if (finished && weakSelf.pageDidLoadImage) {
                          weakSelf.pageDidLoadImage(p1.carImageView.image);
                      }
                  }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIPageViewController

#pragma mark UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllerArray indexOfObject:viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    
    self.currentIndex = index;
    
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
    self.currentIndex = index;
    
    return [self.viewControllerArray objectAtIndex:index];
}

#pragma mark UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if (completed && self.pageDidLoadImage) {
        PhotoViewController *photoViewController = self.viewControllerArray[self.currentIndex];
        self.pageDidLoadImage(photoViewController.carImageView.image);
    }
}

@end
