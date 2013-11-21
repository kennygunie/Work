//
//  FormViewController.m
//  Declaration
//
//  Created by Kien Nguyen on 18/11/2013.
//  Copyright (c) 2013 Kien Nguyen. All rights reserved.
//

#import "FormViewController.h"
#import "UITextView+Utils.h"
#import "UIColor+Utils.h"
#import "NSDate+Utils.h"
#import "Declaration.h"

@interface FormViewController ()

@property BOOL showDatePicker;
@property (weak, nonatomic) IBOutlet UITableViewCell *detailCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *dateCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *datePickerCell;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation FormViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.showDatePicker = NO;
    [self setupDateCellWithDate:self.declaration.date];
    self.titleTextField.placeholder = self.titlePlaceHolder;
    self.detailTextView.text = self.declaration.detail.length > 0 ? self.declaration.detail : self.detailPlaceHolder;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
    if(cell == self.detailCell) {
        //if (self.selectedIndexPath && self.selectedIndexPath.row == indexPath.row) {
        if ([self.detailTextView isFirstResponder]) {
            return 216.0; //set the hidden cell's height to 0
        }
    } else if (cell == self.datePickerCell) {
        if (!self.showDatePicker) {
            return 0;
        }
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.dateCell == cell) {
        self.showDatePicker = !self.showDatePicker;
        [self.detailTextView resignFirstResponder];
        [self.titleTextField resignFirstResponder];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 #warning Potentially incomplete method implementation.
 // Return the number of sections.
 return 0;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 #warning Incomplete method implementation.
 // Return the number of rows in the section.
 return 0;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *CellIdentifier = @"Cell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

#pragma mark - UITextViewDelegate Protocol

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.detailTextView) {
        if ([textView.text isEqualToString:self.detailPlaceHolder]) {
            [textView setText:nil];
        }
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.detailTextView) {
        if (textView.text.length == 0) {
            textView.text = self.detailPlaceHolder;
        }
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

#pragma mark - Utils

- (NSString *)titlePlaceHolder
{
    return NSLocalizedString(@"(Declaration title)" , nil);
}

- (NSString *)detailPlaceHolder
{
    return NSLocalizedString(@"(Declaration detail)" , nil);
}

- (void)setupDateCellWithDate:(NSDate *)date
{
    self.datePicker.date = date;
    self.dateLabel.text = [date dateString];
}

#pragma mark - IBAction
- (IBAction)updateDate:(UIDatePicker *)datePicker
{
    self.dateLabel.text = [datePicker.date dateString];
    self.declaration.date = datePicker.date;
}

#pragma mark - UpdateDeclaration Protocole

- (void)updateDeclaration
{
    self.declaration.title = self.titleTextField.text;
    if ([self.detailTextView.text isEqualToString:self.detailPlaceHolder]) {
        self.declaration.detail = @"";
    } else {
        self.declaration.detail = self.detailTextView.text;
    }
    [self.titleTextField resignFirstResponder];
    [self.detailTextView resignFirstResponder];
}
@end
