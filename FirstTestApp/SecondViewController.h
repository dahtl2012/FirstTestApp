//
//  SecondViewController.h
//  FirstTestApp
//
//  Created by Dominik Arnhof on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *onOffButton;

- (IBAction)onOffPressed:(id)sender;
@end
