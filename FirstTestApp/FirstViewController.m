//
//  FirstViewController.m
//  FirstTestApp
//
//  Created by Dominik Arnhof, Klaus Bauernfeind on 19.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize level;
@synthesize angel;

@synthesize motionManager;
@synthesize x;
@synthesize y;
@synthesize z;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.motionManager = [[CMMotionManager alloc] init];
    if (self.motionManager.accelerometerAvailable) {
        self.motionManager.accelerometerUpdateInterval = 1.0 / 30.0;
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            
            self.x = accelerometerData.acceleration.x;
            self.y = accelerometerData.acceleration.y;
            self.z = accelerometerData.acceleration.z;
            
            // NSLog(@"%f, %f, %f", self.x, self.y, self.z);
            
            double rad = atan2(self.x, self.y) + M_PI;
            double grad = rad * 180 / M_PI;
            
            self.angel.text = [NSString stringWithFormat:@"%03.2f", grad];
            CGAffineTransform rotation = CGAffineTransformMakeRotation(rad);
            self.level.transform = rotation;

        }];
    } else {
        NSLog(@"Kein Accelerometer verfügbar");
    }
}

- (void)viewDidUnload
{
    [self setLevel:nil];
    [self setAngel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end
