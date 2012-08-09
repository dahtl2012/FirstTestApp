//
//  RootViewController.h
//  FirstTestApp
//
//  Created by Dominik Arnhof on 08.08.12.
//
//

#import <CoreLocation/CoreLocation.h>

@interface RootViewController : UITableViewController <CLLocationManagerDelegate> {
    
    NSMutableArray *eventsArray;
    NSManagedObjectContext *managedObjectContext;
    
    CLLocationManager *locationManager;
    UIBarButtonItem *addButton;
}

@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UIBarButtonItem *addButton;

@end