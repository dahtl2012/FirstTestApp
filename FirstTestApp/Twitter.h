//
//  Twitter.h
//  FirstTestApp
//
//  Created by Dominik Arnhof on 18.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>

@interface Twitter : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *count;
@property (strong, nonatomic) IBOutlet UIButton *keyDown;

- (IBAction)tweet:(id)sender;

- (IBAction)down:(id)sender;

@end
