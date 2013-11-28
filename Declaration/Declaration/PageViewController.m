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
@property (nonatomic) PageViewControllerDataSource *pageViewControllerDataSource;
@property (nonatomic) UIImagePickerController *imagePickerController;
- (PhotoViewController *)addPhotoViewController;
- (void)propagatePageDidLoadImage:(UIImage *)image
               pageViewController:(PageViewController *)pageViewController;
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
    self.dataSource = self.pageViewControllerDataSource;
    
    PhotoViewController *p1 = [self addPhotoViewController];
    
    __weak typeof(self) weakSelf = self;
    
    [self setViewControllers:@[p1]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:^(BOOL finished) {
                      if (p1.carImageView.image && finished) {
                          [weakSelf propagatePageDidLoadImage:p1.carImageView.image
                                           pageViewController:weakSelf];
                      }
                  }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils

- (void)propagatePageDidLoadImage:(UIImage *)image
               pageViewController:(PageViewController *)pageViewController
{
    if (pageViewController.pageDidLoadImage) {
        pageViewController.pageDidLoadImage(image);
    }
}


- (PhotoViewController *)addPhotoViewController;
{
    PhotoViewController *photoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    photoViewController.pickerDidSelected = ^{
        [self presentViewController:self.imagePickerController
                           animated:YES
                         completion:nil];
    };
    [self.pageViewControllerDataSource.viewControllers addObject:photoViewController];
    return photoViewController;
}

#pragma mark - Getters & setters


- (PageViewControllerDataSource *)pageViewControllerDataSource
{
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (_pageViewControllerDataSource == nil) {
        _pageViewControllerDataSource = [[PageViewControllerDataSource alloc] init];
    }
    return _pageViewControllerDataSource;
}

- (UIImagePickerController *)imagePickerController
{
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
        _imagePickerController.delegate = self;
    }
    return _imagePickerController;
}
#pragma mark - Delegate
#pragma mark UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if (completed && finished) {
        PhotoViewController *photoViewController = [pageViewController.viewControllers firstObject];
        if (photoViewController.carImageView.image
            &&finished) {
            [self propagatePageDidLoadImage:photoViewController.carImageView.image
                         pageViewController:self];
        }
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        PhotoViewController *photoViewController = [self.viewControllers firstObject];
        [photoViewController setImage:image];
        [self propagatePageDidLoadImage:image
                     pageViewController:self];
        [self addPhotoViewController];
    }
}

@end
