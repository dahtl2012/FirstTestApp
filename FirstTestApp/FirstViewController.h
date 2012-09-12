//
//  FirstViewController.h
//  FirstTestApp
//
//  Created by Dominik Arnhof on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface FirstViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *level;
@property (strong, nonatomic) IBOutlet UILabel *angel;

@property (strong) CMMotionManager *motionManager;
@property (assign) double x;
@property (assign) double y;
@property (assign) double z;

@end
