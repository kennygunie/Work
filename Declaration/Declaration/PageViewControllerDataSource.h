//
//  PageViewControllerDataSource.h
//  Declaration
//
//  Created by Kien Nguyen on 27/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageViewControllerDataSource : NSObject <UIPageViewControllerDataSource>
@property (nonatomic) NSMutableArray *viewControllers; // of UIViewController
@end
