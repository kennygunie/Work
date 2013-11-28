//
//  SlideViewController.m
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "PageViewController.h"
#import "PhotoViewController.h"
#import "PageViewControllerDataSource.h"

@interface PageViewController ()
@property (strong, nonatomic) PageViewControllerDataSource *pageViewControllerDataSource;
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
    
    self.delegate = self;
    
    UIStoryboard *storyboard = self.storyboard;
    
    PhotoViewController *p1 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    p1.imageName = @"a1";
    
    PhotoViewController *p2 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    p2.imageName = @"a2";
    
    PhotoViewController *p3 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    p3.imageName = @"a3";

    PhotoViewController *p4 = [storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    
    self.pageViewControllerDataSource.viewControllerArray = @[p1, p2, p3, p4];
    
    __weak typeof(self) weakSelf = self;
    self.dataSource = self.pageViewControllerDataSource;
    
    [self setViewControllers:@[p1]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
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

#pragma mark - Getters & setters

- (PageViewControllerDataSource *)pageViewControllerDataSource
{
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_pageViewControllerDataSource) {
        _pageViewControllerDataSource = [[PageViewControllerDataSource alloc] init];
    }
    return _pageViewControllerDataSource;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if (completed && finished && self.pageDidLoadImage) {
        //unsigned index = [self.viewControllerArray indexOfObject:[previousViewControllers firstObject]] + 1;
        //PhotoViewController *photoViewController = self.viewControllerArray[index];
    }
}

@end
