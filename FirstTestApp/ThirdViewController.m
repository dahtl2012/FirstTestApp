//
//  ThirdViewController.m
//  FirstTestApp
//
//  Created by Dominik Arnhof on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize display;
@synthesize userIsTypingNumber;
@synthesize waitingOperand;
@synthesize waitingOperation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)digitPressed:(id)sender {
    UIButton *button = sender;
    if (!self.userIsTypingNumber) {
        self.display.text = @"";
        self.userIsTypingNumber = YES;
    }
    self.display.text = [self.display.text stringByAppendingString: [button currentTitle]];
}

- (IBAction)commaPressed:(id)sender {
    if ([self.display.text rangeOfString:@"."].location == NSNotFound) {
        self.display.text = [self.display.text stringByAppendingString: @"."];
    }
}

- (IBAction)operationPressed:(id)sender {
    UIButton *button = sender;
    
    self.userIsTypingNumber = NO;
    self.display.text = [self performOperation:[button currentTitle] withOperand: [self.display.text doubleValue]];
}

- (NSString*) performOperation: (NSString*) operation withOperand: (double) operand {
    if ([operation isEqualToString:@"C"]) {
        return @"";
    } else if ([operation isEqualToString:@"AC"]) {
        self.waitingOperand = 0.0;
        self.waitingOperation = nil;
        return @"";
    } else if ([self.waitingOperation isEqualToString:@"+"]) {
        operand = self.waitingOperand + operand;
    } else if ([self.waitingOperation isEqualToString:@"-"]) {
        operand = self.waitingOperand - operand;
    } else if ([self.waitingOperation isEqualToString:@"*"]) {
        operand = self.waitingOperand * operand;
    } else if ([self.waitingOperation isEqualToString:@"/"]) {
        operand = self.waitingOperand / operand;
    }
    
    self.waitingOperand = operand;
    self.waitingOperation = operation;
    return [NSString stringWithFormat:@"%g", operand];
}

@end
