//
//  TableViewController.h
//  TableViewSB
//
//  Created by Dominik Arnhof on 25.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"

@interface TableViewController : UITableViewController <AddViewControllerDelegate> //id<UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *data;

- (IBAction)editPressed:(id)sender;
- (IBAction)addPressed:(id)sender;

- (void) loadData;
- (void) saveData;

-(void)controller:(AddViewController *)controller didFinishEnteringTask:(NSString *)task;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end
