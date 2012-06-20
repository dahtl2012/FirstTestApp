//
//  ThirdViewController.h
//  FirstTestApp
//
//  Created by Dominik Arnhof on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *display;

- (IBAction)digitPressed:(id)sender;
- (IBAction)commaPressed:(id)sender;
- (IBAction)operationPressed:(id)sender;

@property (nonatomic, assign) BOOL userIsTypingNumber;
@property (nonatomic, assign) double waitingOperand;
@property (nonatomic, assign) NSString *waitingOperation;

- (NSString*) performOperation: (NSString*) operation withOperand: (double) operand;

@end
