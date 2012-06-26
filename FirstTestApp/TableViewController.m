//
//  TableViewController.m
//  TableViewSB
//
//  Created by Dominik Arnhof on 25.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize data = _data;

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
    
    [self loadData];
    
    if (!self.data) {
        self.data = [[NSMutableArray alloc] init];
        [self.data addObject:@"Eins"];
        [self.data addObject:@"Zwei"];
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.data removeObjectAtIndex:indexPath.row];
        [self saveData];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Geklickt auf %@", [self.data objectAtIndex:indexPath.row]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ändern" 
                                                    message:nil 
                                                   delegate:self 
                                          cancelButtonTitle:@"Abbruch" 
                                          otherButtonTitles:@"Ok", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert textFieldAtIndex:0].text = [self.data objectAtIndex:indexPath.row];
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        if ([alertView.title isEqualToString:@"Ändern"]) {
            int row = [self.tableView indexPathForSelectedRow].row;
            if ([[alertView textFieldAtIndex:0].text length] >0) {
                [self.data replaceObjectAtIndex:row withObject:[alertView textFieldAtIndex:0].text];
                [self.tableView reloadData];
                [self saveData];
            }
            else {
                [self.data removeObjectAtIndex:row];
                NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
                NSArray *array = [NSArray arrayWithObject:path];
                [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
                [self saveData];
            }
        } else if ([alertView.title isEqualToString:@"Neu"]) {
            if ([[alertView textFieldAtIndex:0].text length] >0) {
                [self.data addObject:[alertView textFieldAtIndex:0].text];
                [self.tableView reloadData];
                [self saveData];
            }
        }
       
    }
}

- (IBAction)editPressed:(id)sender {
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed:)];
    
    [self.navigationItem setLeftBarButtonItem:doneButton animated:YES];
    
    [self.tableView setEditing:YES animated:YES];
}



- (IBAction)donePressed:(id)sender {
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editPressed:)];
    
    [self.navigationItem setLeftBarButtonItem:editButton animated:YES];
    
    [self.tableView setEditing:NO animated:YES];

}

- (IBAction)addPressed:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Neu" message:nil delegate:self cancelButtonTitle:@"Abbruch" otherButtonTitles:@"Ok", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert show];
}

- (void) loadData {
    
    self.data = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/data", NSHomeDirectory()]];
}

- (void) saveData {
    
    [self.data writeToFile:[NSString stringWithFormat:@"%@/Documents/data", NSHomeDirectory()] atomically:YES];
}

@end
