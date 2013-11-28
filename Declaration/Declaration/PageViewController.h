//
//  SlideViewController.h
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Declaration;

@interface PageViewController : UIPageViewController <UIPageViewControllerDelegate>
@property (nonatomic, copy) void (^pageDidLoadImage)(UIImage *image);
@property (weak, nonatomic) Declaration *declaration;
@end
