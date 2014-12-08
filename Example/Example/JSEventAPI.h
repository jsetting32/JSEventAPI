//
//  JSEventAPI.h
//  Example
//
//  Created by John Setting on 12/5/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSCurrentLocation.h"
#import "JSEventObject.h"
#import "JSPerformerObject.h"
#import "JSVenueObject.h"
#import "JSDemandsObject.h"
#import "JSEventAPIConstants.h"

@protocol JSEventAPIDelegate;
@interface JSEventAPI : NSObject

/*!
 @abstract The legitimate way to instantiate the object
 */
+ (id) sharedInstance;


/*!
 @abstract Resets the page counters to 1

 @discussion Use to load the first page of the feeds. Must be called when making your first query
 */
- (void)resetPageCounters;

/*!
 @abstract Eventful API Key
 
 @discussion You must specify an API key Eventful assigns you and set this accordingly before making any queries
 */
@property (nonatomic) NSString * apiKey;

/*!
 @abstract Only become the delegate of this class if you want to receive the users current location
 */
@property (nonatomic, weak) id <JSEventAPIDelegate>delegate;

/*!
 @abstract Handles getting the users current location.
 
 @discussion It is required that you ensure your info.plist has the following fields
 'NSLocationWhenInUseUsageDescription', 'privacy - location usage description', and/or
 'NSLocationAlwaysUsageDescription' filled with a user friendly message.
 
 Conform as the delegate of this class to further query for weather data
 */
- (void)getCurrentLocation;

/*!
 @abstract Query for a specific event in the Eventful API
 
 @discussion Given a event ID, returns the event data associated with that event.
 
 @param eventId The ID of the requested event.
 */
- (void)queryForEventById:(NSString *)eventId block:(void(^)(JSEventObject * event, NSError * error))completionBlock;

/*!
 @abstract Query for Events within Eventful API
 
 @discussion The query will return at most 10 JSEventObjects within an NSArray object
 
 @param keywords    The search keywords.
 @param coords      An NSDictionary Object with keys of 'latitude' and 'longitude' (e.g. @{@"latitude":@"32.032",@"longitude":@"42.142"})
 @param location    A location name to use in filtering the search results. Locations in the
                    form "San Diego", "San Diego, TX", "London, United Kingdom", and
                    "Calgary, Alberta, Canada" are accepted, as are postal codes ("92122") and
                    venue IDs ("V0-001-000268633-5")
 @param date        Currently supported labels include: "All", "Future", "Past", "Today", "Last Week",
                    "This Week", "Next week", and months by name, e.g. "October".
 @param category    Limit the search results to this category ID. A list of categories may be
                    specified separated by commas.
 @param radius      If radius is set and the "coords" parameter resolves to a specific geolocation,
                    the search will be restricted to the specified radius
 @param metric      One of "mi" or "km", the units of the "within" parameter. Defaults to "mi
 @param type        One of 'popularity', 'date', or 'relevance'. Default is 'relevance
 @param direction   One of 'ascending' or 'descending'. Default varies by sort_order
 @param censored    Sets the level of filtering for events marked as "mature" due to keywords in
                    the title or description. Defaults to No.
 */
- (void)queryForEventsWithKeywords:(NSString *)keywords
                         geoCoords:(NSDictionary *)coords
                          location:(NSString *)location
                              date:(NSString *)date
                          category:(NSString *)category
                      withinRadius:(id)radius
                      radiusMetric:(NSString *)metric
                        sortByType:(NSString *)type
                     sortDirection:(NSString *)direction
                          censored:(BOOL)censored
                             block:(void(^)(NSArray *objects, NSError *error))completionblock;


/*!
 @abstract Query for a specific venue in the Eventful API
 
 @discussion Given a venue ID, returns the venue data associated with that venue.
 
 @param eventId The ID of the requested venue.
 */
- (void)queryForVenueById:(NSString *)venueId block:(void(^)(JSVenueObject * venue, NSError * error))completionBlock;

/*!
 @abstract Query for Venues within Eventful API
 
 @discussion The query will return at most 10 JSVenueObjects within an NSArray object
 
 @param keywords    The search keywords.
 @param coords      An NSDictionary Object with keys of 'latitude' and 'longitude' (e.g. @{@"latitude":@"32.032",@"longitude":@"42.142"})
 @param location    A location name to use in filtering the search results. Locations in the
                    form "San Diego", "San Diego, TX", "London, United Kingdom", and
                    "Calgary, Alberta, Canada" are accepted, as are postal codes ("92122")
 @param radius      If radius is set and the "coords" parameter resolves to a specific geolocation,
                    the search will be restricted to the specified radius
 @param metric      One of "mi" or "km", the units of the "within" parameter. Defaults to "mi
 @param type        One of 'popularity', 'date', or 'relevance'. Default is 'relevance
 @param direction   One of 'ascending' or 'descending'. Default varies by sort_order
 */
- (void)queryForVenuesWithKeywords:(NSString *)keywords
                         geoCoords:(NSDictionary *)coords
                          location:(NSString *)location
                        withRadius:(id)radius
                      radiusMetric:(NSString *)metric
                        sortByType:(NSString *)type
                     sortDirection:(NSString *)direction
                             block:(void(^)(NSArray *objects, NSError *error))completionblock;

/*!
 @abstract Query for a specific performer in the Eventful API
 
 @discussion Given a performer ID, returns the performer data associated with that performer.
 
 @param performerId The ID of the requested performer.
 */
- (void)queryForPerformerById:(NSString *)performerId block:(void(^)(JSPerformerObject * performer, NSError * error))completionBlock;

/*!
 @abstract Query for Performers within Eventful API
 
 @discussion The query will return at most 10 JSPerformerObjects within an NSArray object
 
 @param keywords    The search keywords.
 @param type        One of 'popularity', 'date', or 'relevance'. Default is 'relevance
 @param direction   One of 'ascending' or 'descending'. Default varies by sort_order
 */
- (void)queryForPerformersWithKeywords:(NSString *)keywords
                            sortByType:(NSString *)type
                         sortDirection:(NSString *)direction
                                 block:(void(^)(NSArray *objects, NSError *error))completionblock;


/*!
 @abstract Query for a specific demand in the Eventful API
 
 @discussion Given a demand ID, returns the demand data associated with that demand.
 
 @param demandId The ID of the requested demand.
 */
- (void)queryForDemandById:(NSString *)demandId block:(void(^)(JSDemandsObject * demand, NSError * error))completionBlock;

/*!
 @abstract Query for Demanded Events within Eventful API
 
 @discussion The query will return at most 10 JSDemandEventObject within an NSArray object
 
 @param keywords    The search keywords.
 @param coords      An NSDictionary Object with keys of 'latitude' and 'longitude' (e.g. @{@"latitude":@"32.032",@"longitude":@"42.142"})
 @param location    A location name to use in filtering the search results. Locations in the
                    form "San Diego", "San Diego, TX", "London, United Kingdom", and
                    "Calgary, Alberta, Canada" are accepted, as are postal codes ("92122")
 @param type        One of 'popularity', 'date', or 'relevance'. Default is 'relevance
 @param direction   One of 'ascending' or 'descending'. Default varies by sort_order
 */
- (void)queryForDemandsWithKeywords:(NSString *)keywords
                          geoCoords:(NSDictionary *)coods
                           location:(NSString *)location
                         sortByType:(NSString *)type
                      sortDirection:(NSString *)direction
                              block:(void(^)(NSArray *objects, NSError *error))completionblock;

/*!
 @abstract Query for all Categories within Eventful API
 
 @discussion The query will return all the categories Eventful Offers within an NSArray object
 */
- (void)queryForCategories:(void(^)(NSArray * categories, NSError *error))completionblock;


@end

/*!
 The protocol defines methods a delegate of a JSEventAPI should implement.
 */
@protocol JSEventAPIDelegate <NSObject>
@optional
/*!
 Sent to the delegate when the current user's location was found
 @param dict A dictionary object whose keys are the city and region of the user's location (e.g 'San Francisco,CA')
 */
- (void)JSEventAPI:(JSEventAPI *)eventAPI didReceiveCurrentLocation:(NSDictionary *)dict;
/*!
 Sent to the delegate when there was an error finding the user's current location
 @param dict An NSError object
 */
- (void)JSEventAPI:(JSEventAPI *)eventAPI didReceiveCurrentLocationError:(NSError *)error;
@end
