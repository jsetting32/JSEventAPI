//
//  ViewController.m
//  Example
//
//  Created by John Setting on 12/5/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import "ViewController.h"
#import "JSEventAPI.h"
#import "JSEventObject.h"
#import "JSPerformerObject.h"
#import "JSVenueObject.h"
#import "JSDemandsObject.h"

#define kJSEventAPIKey @"jv2WCKLdZjgb5w9s"

@interface ViewController () <JSEventAPIDelegate>
@property (nonatomic) UIActivityIndicatorView *indicator;
@end

@implementation ViewController
@synthesize indicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    JSEventAPI *eventAPI = [JSEventAPI sharedInstance];
    [eventAPI setApiKey:kJSEventAPIKey];
    [eventAPI setDelegate:self];
    [eventAPI getCurrentLocation];
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator setFrame:CGRectMake(self.view.frame.size.width / 2.0f - indicator.frame.size.width / 2.0f,
                                   self.view.frame.size.height / 2.0f - indicator.frame.size.height / 2.0f,
                                   indicator.frame.size.width, indicator.frame.size.height)];
    [self.view addSubview:indicator];
    
}

- (IBAction)didTapNext:(id)sender {
    [indicator startAnimating];
    
    
    [[JSEventAPI sharedInstance] queryForEventsWithKeywords:nil geoCoords:nil location:@"San Francisco, CA" date:nil category:nil withinRadius:nil radiusMetric:nil sortByType:nil sortDirection:nil censored:nil block:^(NSArray *objects, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        for (JSEventObject *obj in objects) {
            NSLog(@"%@", obj.objects);
        }

    }];
    
    
    /*
    [[JSEventAPI sharedInstance] queryForVenueById:@"V0-001-002084688-9" block:^(JSVenueObject *venue, NSError *error) {
        [indicator stopAnimating];
        NSLog(@"%@", venue.objects);
    }];
    */
    
    /*
    [[JSEventAPI sharedInstance] queryForVenuesWithKeywords:nil geoCoords:nil location:@"San Francisco,CA" withRadius:nil radiusMetric:nil sortByType:nil sortDirection:nil block:^(NSArray *objects, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        //for (JSVenueObject *obj in objects) {
        //    NSLog(@"%@", obj.objects);
        //}
    }];
    */
    
    /*
    [[JSEventAPI sharedInstance] queryForPerformersWithKeywords:@"Linkin Park" sortByType:nil sortDirection:nil block:^(NSArray *objects, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        
        for (JSPerformerObject *obj in objects) {
            NSLog(@"%@", obj.objects);
        }
    }];
    */
    
    /*
    [[JSEventAPI sharedInstance] queryForDemandsWithKeywords:nil geoCoords:nil location:@{@"city":@"San Francisco",@"state":@"CA"} sortByType:nil sortDirection:nil block:^(NSArray *objects, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        for (JSDemandsObject *obj in objects) {
            NSLog(@"%@", obj.objects);
        }
    }];
    */
}

- (void)JSEventAPI:(JSEventAPI *)weather didReceiveCurrentLocation:(NSDictionary *)dict
{
    [indicator startAnimating];
    
    /*
    [[JSEventAPI sharedInstance] queryForEventById:@"E0-001-078254593-2" block:^(JSEventObject *event, NSError *error) {
        [indicator stopAnimating];
        NSLog(@"%@", event.objects);
    }];
    */
    
    
    [[JSEventAPI sharedInstance] queryForEventsWithKeywords:nil geoCoords:nil location:@"San Francisco, CA" date:nil category:nil withinRadius:nil radiusMetric:nil sortByType:nil sortDirection:nil censored:nil block:^(NSArray *objects, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        for (JSEventObject *obj in objects) {
            NSLog(@"%@", obj.objects);
        }
        
    }];
    
    
    /*
    [[JSEventAPI sharedInstance] queryForVenueById:@"V0-001-002084688-9" block:^(JSVenueObject *venue, NSError *error) {
        [indicator stopAnimating];
        NSLog(@"%@", venue.objects);
    }];
    */
    
     /*
    [[JSEventAPI sharedInstance] queryForVenuesWithKeywords:nil geoCoords:nil location:@"San Francisco,CA" withRadius:nil radiusMetric:nil sortByType:nil sortDirection:nil block:^(NSArray *objects, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        //for (JSVenueObject *obj in objects) {
        //    NSLog(@"%@", obj.objects);
        //}
    }];
    */
    
    /*
    [[JSEventAPI sharedInstance] queryForPerformerById:@"P0-001-000000790-5" block:^(JSPerformerObject *performer, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        NSLog(@"%@", performer.objects);
    }];
     */
    
    /*
    [[JSEventAPI sharedInstance] queryForPerformersWithKeywords:nil sortByType:nil sortDirection:nil block:^(NSArray *objects, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        
        for (JSPerformerObject *obj in objects) {
            NSLog(@"%@", obj.objects);
        }
    }];
    */
    
    /*
    [[JSEventAPI sharedInstance] queryForDemandById:@"D0-001-000000045-2" block:^(JSDemandsObject *demand, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
    
        NSLog(@"%@", demand.objects);
        
    }];
    */
    
    
    /*
    [[JSEventAPI sharedInstance] queryForDemandsWithKeywords:nil geoCoords:nil location:nil sortByType:nil sortDirection:nil block:^(NSArray *objects, NSError *error) {
        [indicator stopAnimating];
        if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            return;
        }
        
        for (JSDemandsObject *obj in objects) {
            NSLog(@"%@", obj.objects);
        }
    }];
    */
    
    
    /*
    [[JSEventAPI sharedInstance] queryForCategories:^(NSArray *categories, NSError *error) {
        NSLog(@"%@", categories);
    }];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
