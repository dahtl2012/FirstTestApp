//
//  AddViewController.h
//  FirstTestApp
//
//  Created by Dominik Arnhof on 26.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddViewController;

@protocol AddViewControllerDelegate <NSObject>

- (void) controller: (AddViewController*) controller didFinishEnteringTask: (NSString*) task;

@end

@interface AddViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *taskField;
@property (nonatomic, weak) id <AddViewControllerDelegate> delegate;
@property(nonatomic) NSString *task;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)donePressed:(id)sender;
@end
