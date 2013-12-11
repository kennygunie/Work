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
#import "Declaration.h"

@interface PageViewController ()
@property (nonatomic) PageViewControllerDataSource *pageViewControllerDataSource;
@property (nonatomic) UIImagePickerController *imagePickerController;
- (PhotoViewController *)createPhotoViewController;
- (void)pageDidLoadWithImage:(UIImage *)image;
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
    
    [self setViewControllers:@[[self createPhotoViewController]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils

- (void)pageDidLoadWithImage:(UIImage *)image
{
    if (image && self.pageDidLoadImage) {
        self.pageDidLoadImage(image);
    }
}


- (PhotoViewController *)createPhotoViewController;
{
    static NSString* PhotoViewControllerIdentifier = @"PhotoViewController";
    PhotoViewController *photoViewController = [self.storyboard instantiateViewControllerWithIdentifier:PhotoViewControllerIdentifier];
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
        if (finished) {
            [self pageDidLoadWithImage:photoViewController.carImageView.image];
        }
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        [self.declaration addPhotosObject:image];
        PhotoViewController *photoViewController = [self.viewControllers firstObject];
        [photoViewController setImage:image];
        [self pageDidLoadWithImage:image];
        [self createPhotoViewController];
        
        [self setViewControllers:@[photoViewController]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:nil];
    }
}

@end
