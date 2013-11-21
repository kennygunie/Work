//
//  FormViewController.h
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateDeclaration.h"
@class Declaration;

@interface FormViewController : UITableViewController <UpdateDeclaration>
@property (weak, nonatomic) Declaration *declaration;
@end
