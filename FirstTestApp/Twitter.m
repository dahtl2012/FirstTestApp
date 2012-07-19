//
//  Twitter.m
//  FirstTestApp
//
//  Created by Dominik Arnhof on 18.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Twitter.h"

@interface Twitter ()

@end

@implementation Twitter
@synthesize textView;
@synthesize count;
@synthesize keyDown;
@synthesize data = _data;
@synthesize tableView;

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
    
    [self loadData];
    if (!self.data) {
        self.data = [[NSMutableArray alloc] init];
    }
    [self.tableView reloadData];
    
    [self.keyDown setHidden:TRUE];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"UITextViewTextDidChangeNotification" object:nil queue:nil usingBlock:^(NSNotification *note) {
        int help = 140 - [self.textView.text length];
        if (help > 0) {
            self.count.text = [NSString stringWithFormat:@"%i", help];
            self.textView.editable = YES;
        } else {
            self.count.text = [NSString stringWithFormat:@"%i", help];
            self.textView.editable = NO;
        }
        
    }];
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [self setCount:nil];
    [self setKeyDown:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tweet:(id)sender {
    
    self.textView.editable = YES;
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    [twitter setInitialText:self.textView.text];
    //[twitter addURL:[NSURL URLWithString:@"http://oanhof.blogspot.com"]];
    
    if ([TWTweetComposeViewController canSendTweet]) {
        [self presentViewController:twitter animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Es geht nicht!" message:@"Sie haben keine Netzwerkverbindung!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
        
        if (TWTweetComposeViewControllerResultDone) {
            /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erfolg" message:@"Erfolgreich getwittert." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];*/
        
            //[self.data addObject:self.textView.text];
            [self.data insertObject:self.textView.text atIndex:0];
            [self.tableView reloadData];
            [self saveData];
            self.textView.text = @"";
            self.count.text = [NSString stringWithFormat:@"%i", 140];
        } else if (TWTweetComposeViewControllerResultCancelled) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh je" message:@"Es hat leider nicht funktioniert, versuchen Sie es später noch einmal!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        [self dismissModalViewControllerAnimated:YES];
    };
    //self.textView.editable = YES;
}

- (IBAction)down:(id)sender {
    [self.textView resignFirstResponder];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    NSLog(@"show");
    [self.keyDown setHidden:FALSE];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    NSLog(@"hide");
    [self.keyDown setHidden:TRUE];
    return YES;
}

- (void) loadData {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.data = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/tweets", NSHomeDirectory()]];
}

- (void) saveData {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.data writeToFile:[NSString stringWithFormat:@"%@/Documents/tweets", NSHomeDirectory()] atomically:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [self.data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    static NSString *CellIdentifier = @"tweets";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"<Platzhalter für Datum>";
    
    return cell;
}
@end
