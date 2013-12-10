//
//  FormViewController.h
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Declaration;

@interface FormViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) Declaration *declaration;

- (void)submitDeclaration;
@end
