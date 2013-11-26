//
//  ImageViewController.h
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (strong, nonatomic) NSNumber *pageNumber;
@property (copy, nonatomic) NSString *imageName;

@end
