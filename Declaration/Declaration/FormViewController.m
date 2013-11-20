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


#define DESCRIPTION_TEXT_HOLDER @"Description détaillée"

@interface FormViewController ()

@property BOOL showDatePicker;

@property (weak, nonatomic) IBOutlet UITableViewCell *descriptionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *dateCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *datePickerCell;

- (IBAction)updateDate:(id)sender;


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
    self.dateLabel.text = [[NSDate new] dateString];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self.descriptionTextView setText:DESCRIPTION_TEXT_HOLDER
    //                            color:[UIColor placeHolderTextColor]];
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
    
    if(cell == self.descriptionCell) {
        //if (self.selectedIndexPath && self.selectedIndexPath.row == indexPath.row) {
        if ([self.descriptionTextView isFirstResponder]
            || ([self.descriptionTextView.text length] > 0 && ![self.descriptionTextView.text isEqualToString:DESCRIPTION_TEXT_HOLDER])) {
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
    if (textView == self.descriptionTextView) {
        
        if ([textView.text isEqualToString:DESCRIPTION_TEXT_HOLDER]) {
            [textView setText:nil
                        color:[UIColor whiteColor]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.descriptionTextView) {
        if ([textView.text length] == 0) {
            [textView setText:DESCRIPTION_TEXT_HOLDER
                        color:[UIColor lightGrayColor]];
        }
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

#pragma mark - Utils


#pragma mark - IBAction
- (IBAction)updateDate:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    self.dateLabel.text = [datePicker.date dateString];
    
}
@end
