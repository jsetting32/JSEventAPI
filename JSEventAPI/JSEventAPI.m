//
//  JSEventAPI.m
//  Example
//
//  Created by John Setting on 12/5/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import "JSEventAPI.h"

enum {
    JSQueryEvents = 0,
    JSQueryVenues = 1,
    JSQueryPerformers,
    JSQueryDemands,
    JSQueryCategories
}; NSInteger queryType;

@interface JSEventAPI() <JSCurrentLocationDelegate>
@property (nonatomic, strong) JSCurrentLocation *JSLocation;
@property (nonatomic) NSInteger eventsPageNumber;
@property (nonatomic) NSInteger venuesPageNumber;
@property (nonatomic) NSInteger performersPageNumber;
@property (nonatomic) NSInteger demandsPageNumber;
@end

@implementation JSEventAPI

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static JSEventAPI *instance;
    dispatch_once(&once, ^{ instance = [[JSEventAPI alloc] init]; });
    return instance;
}


- (id)init
{
    if (!(self = [super init])) return nil;
    [self resetPageCounters];
    return self;
}

- (void)resetPageCounters
{
    self.eventsPageNumber = 1;
    self.venuesPageNumber = 1;
    self.performersPageNumber = 1;
    self.demandsPageNumber = 1;
}

- (void)getCurrentLocation
{
    self.JSLocation = [JSCurrentLocation sharedInstance];
    [self.JSLocation setDelegate:self];
    [self.JSLocation getCurrentLocation];
}

- (void)queryForEventById:(NSString *)eventId block:(void (^)(JSEventObject * event, NSError *error))completionBlock
{
    if ([self.apiKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"You need to specify an API Key. Head over to Eventful's API website and request one!"];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Head over to Eventful's API website and request one!"}];
        completionBlock(nil, error);
        return;
    }
    
    NSString *query = [self generateQueryWithType:JSQueryEvents
                                         objectId:eventId
                                         keywords:nil
                                        geoCoords:nil
                                         location:nil
                                             date:nil
                                         category:nil
                                     withinRadius:nil
                                     radiusMetric:nil
                                       sortByType:nil
                                    sortDirection:nil
                                         censored:nil];

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               if (error) {
                                   completionBlock(nil, error);
                                   return;
                               }
                    
                               
                               NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               completionBlock([[JSEventObject alloc] initWithData:json], nil);
                               return;
                           }];
    
}

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
                             block:(void(^)(NSArray *objects, NSError *error))completionblock
{
    if ([self.apiKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"You need to specify an API Key. Head over to Eventful's API website and request one!"];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Head over to Eventful's API website and request one!"}];
        completionblock(nil, error);
        return;
    }
    
    NSString *query = [self generateQueryWithType:JSQueryEvents
                                         objectId:nil
                                         keywords:keywords
                                        geoCoords:coords
                                         location:location
                                             date:date
                                         category:category
                                     withinRadius:radius
                                     radiusMetric:metric
                                       sortByType:type
                                    sortDirection:direction
                                         censored:censored];

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               if (error) {
                                   completionblock(nil, error);
                                   return;
                               }
                               
                               NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               
                               NSMutableArray *arr = [NSMutableArray array];
                               if ([json[@"events"] isEqual:[NSNull null]]) {
                                   NSString *reason = [NSString stringWithFormat:@"Apparently there are no results for this query."];
                                   NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                                                        code:301
                                                                    userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                                               NSLocalizedRecoverySuggestionErrorKey:@"Pass different parameters."}];
                                   completionblock(nil, error);
                                   return;
                               }
                               
                               NSArray *events = json[@"events"][@"event"];
                               for (NSDictionary *dict in events) {
                                   JSEventObject *event = [[JSEventObject alloc] initWithData:dict];
                                   [arr addObject:event];
                               }
                               self.eventsPageNumber++;
                               completionblock(arr, nil);
                               return;
                           }];
}

- (void)queryForVenueById:(NSString *)venueId block:(void (^)(JSVenueObject * venue, NSError *error))completionBlock
{
    if ([self.apiKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"You need to specify an API Key. Head over to Eventful's API website and request one!"];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Head over to Eventful's API website and request one!"}];
        completionBlock(nil, error);
        return;
    }
    
    NSString *query = [self generateQueryWithType:JSQueryVenues
                                         objectId:venueId
                                         keywords:nil
                                        geoCoords:nil
                                         location:nil
                                             date:nil
                                         category:nil
                                     withinRadius:nil
                                     radiusMetric:nil
                                       sortByType:nil
                                    sortDirection:nil
                                         censored:nil];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               if (error) {
                                   completionBlock(nil, error);
                                   return;
                               }
                               
                               NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               JSVenueObject *obj = [[JSVenueObject alloc] initWithData:json];
                               completionBlock(obj, nil);
                           }];
    
}

- (void)queryForVenuesWithKeywords:(NSString *)keywords
                         geoCoords:(NSDictionary *)coords
                          location:(NSString *)location
                        withRadius:(id)radius
                      radiusMetric:(NSString *)metric
                        sortByType:(NSString *)type
                     sortDirection:(NSString *)direction
                             block:(void(^)(NSArray *objects, NSError *error))completionblock
{
    if ([self.apiKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"You need to specify an API Key. Head over to Eventful's API website and request one!"];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Head over to Eventful's API website and request one!"}];
        completionblock(nil, error);
        return;
    }
    
    NSString *query = [self generateQueryWithType:JSQueryVenues
                                         objectId:nil
                                         keywords:keywords
                                        geoCoords:coords
                                         location:location
                                             date:nil
                                         category:nil
                                     withinRadius:radius
                                     radiusMetric:metric
                                       sortByType:type
                                    sortDirection:direction
                                         censored:nil];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               if (error) {
                                   completionblock(nil, error);
                                   return;
                               }
                               
                               NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               
                               NSMutableArray *arr = [NSMutableArray array];
                               if ([json[@"venues"] isEqual:[NSNull null]]) {
                                   NSString *reason = [NSString stringWithFormat:@"Apparently there are no results for this query."];
                                   NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                                                        code:301
                                                                    userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                                               NSLocalizedRecoverySuggestionErrorKey:@"Pass different parameters."}];
                                   completionblock(nil, error);
                                   return;
                               }
                               
                               NSArray *events = json[@"venues"][@"venue"];
                               for (NSDictionary *dict in events) {
                                   JSVenueObject *event = [[JSVenueObject alloc] initWithData:dict];
                                   [arr addObject:event];
                               }
                               self.venuesPageNumber++;
                               completionblock(arr, nil);
                               return;
                               
                           }];

}

- (void)queryForPerformerById:(NSString *)performerId block:(void (^)(JSPerformerObject * performer, NSError * error))completionBlock
{
    if ([self.apiKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"You need to specify an API Key. Head over to Eventful's API website and request one!"];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Head over to Eventful's API website and request one!"}];
        completionBlock(nil, error);
        return;
    }
    
    NSString *query = [self generateQueryWithType:JSQueryPerformers
                                         objectId:performerId
                                         keywords:nil
                                        geoCoords:nil
                                         location:nil
                                             date:nil
                                         category:nil
                                     withinRadius:nil
                                     radiusMetric:nil
                                       sortByType:nil
                                    sortDirection:nil
                                         censored:nil];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               if (error) {
                                   completionBlock(nil, error);
                                   return;
                               }
                               
                               NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               JSPerformerObject *obj = [[JSPerformerObject alloc] initWithData:json];
                               completionBlock(obj, nil);
                           }];

}

- (void)queryForPerformersWithKeywords:(NSString *)keywords
                            sortByType:(NSString *)type
                         sortDirection:(NSString *)direction
                                 block:(void(^)(NSArray *objects, NSError *error))completionblock
{
    if ([self.apiKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"You need to specify an API Key. Head over to Eventful's API website and request one!"];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Head over to Eventful's API website and request one!"}];
        completionblock(nil, error);
        return;
    }
    
    if (!keywords || [keywords length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"The 'keywords' parameter is required."];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Set the parameter to a string that represents a performer"}];
        completionblock(nil, error);
        return;
    }
    
    NSString *query = [self generateQueryWithType:JSQueryPerformers
                                         objectId:nil
                                         keywords:keywords
                                        geoCoords:nil
                                         location:nil
                                             date:nil
                                         category:nil
                                     withinRadius:nil
                                     radiusMetric:nil
                                       sortByType:type
                                    sortDirection:direction
                                         censored:nil];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               if (error) {
                                   completionblock(nil, error);
                                   return;
                               }
                               
                               NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               
                               NSMutableArray *arr = [NSMutableArray array];
                               if ([json[@"performers"] isEqual:[NSNull null]]) {
                                   NSString *reason = [NSString stringWithFormat:@"Apparently there are no results for this query."];
                                   NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                                                        code:301
                                                                    userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                                               NSLocalizedRecoverySuggestionErrorKey:@"Pass different parameters."}];
                                   completionblock(nil, error);
                                   return;
                               }
                                                              
                               NSArray *events = json[@"performers"][@"performer"];
                               for (NSDictionary *dict in events) {
                                   JSPerformerObject *event = [[JSPerformerObject alloc] initWithData:dict];
                                   [arr addObject:event];
                               }
                               self.performersPageNumber++;
                               completionblock(arr, nil);
                               return;
                           }];

}

- (void)queryForDemandById:(NSString *)demandId block:(void (^)(JSDemandsObject * demand, NSError * error))completionBlock
{
    if ([self.apiKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"You need to specify an API Key. Head over to Eventful's API website and request one!"];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Head over to Eventful's API website and request one!"}];
        completionBlock(nil, error);
        return;
    }
    
    NSString *query = [self generateQueryWithType:JSQueryDemands
                                         objectId:demandId
                                         keywords:nil
                                        geoCoords:nil
                                         location:nil
                                             date:nil
                                         category:nil
                                     withinRadius:nil
                                     radiusMetric:nil
                                       sortByType:nil
                                    sortDirection:nil
                                         censored:nil];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               if (error) {
                                   completionBlock(nil, error);
                                   return;
                               }
                               
                               NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               JSDemandsObject *obj = [[JSDemandsObject alloc] initWithData:json];
                               completionBlock(obj, nil);
                           }];

}

- (void)queryForDemandsWithKeywords:(NSString *)keywords
                          geoCoords:(NSDictionary *)coords
                           location:(NSString *)location
                         sortByType:(NSString *)type
                      sortDirection:(NSString *)direction
                              block:(void(^)(NSArray *objects, NSError *error))completionblock
{
    if ([self.apiKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"You need to specify an API Key. Head over to Eventful's API website and request one!"];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Head over to Eventful's API website and request one!"}];
        completionblock(nil, error);
        return;
    }
    
    if (!keywords || [keywords length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"The 'keywords' parameter is required."];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Set the parameter to a string that represents a performer"}];
        completionblock(nil, error);
        return;
    }
    
    NSString *query = [self generateQueryWithType:JSQueryDemands
                                         objectId:nil
                                         keywords:keywords
                                        geoCoords:coords
                                         location:location
                                             date:nil
                                         category:nil
                                     withinRadius:nil
                                     radiusMetric:nil
                                       sortByType:type
                                    sortDirection:direction
                                         censored:nil];

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               if (error) {
                                   completionblock(nil, error);
                                   return;
                               }
                               
                               NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               
                               NSMutableArray *arr = [NSMutableArray array];
                               if ([json[@"demands"] isEqual:[NSNull null]]) {
                                   NSString *reason = [NSString stringWithFormat:@"Apparently there are no results for this query."];
                                   NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                                                        code:301
                                                                    userInfo:@{NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                                               NSLocalizedRecoverySuggestionErrorKey:@"Pass different parameters."}];
                                   completionblock(nil, error);
                                   return;
                               }
                               
                               NSArray *events = json[@"demands"][@"demand"];
                               for (NSDictionary *dict in events) {
                                   JSDemandsObject *event = [[JSDemandsObject alloc] initWithData:dict];
                                   [arr addObject:event];
                               }
                               self.demandsPageNumber++;
                               completionblock(arr, nil);
                               return;
                           }];

}

- (void)queryForCategories:(void(^)(NSArray * categories, NSError *error))completionblock
{
    if ([self.apiKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"You need to specify an API Key. Head over to Eventful's API website and request one!"];
        NSError *error = [NSError errorWithDomain:@"com.JSEventAPI.api"
                                             code:301
                                         userInfo:@{
                                                    NSLocalizedFailureReasonErrorKey:reason, NSLocalizedFailureReasonErrorKey:reason,
                                                    NSLocalizedRecoverySuggestionErrorKey:@"Head over to Eventful's API website and request one!"}];
        completionblock(nil, error);
        return;
    }
    
    NSString *query = [self generateQueryWithType:JSQueryCategories
                                         objectId:nil
                                         keywords:nil
                                        geoCoords:nil
                                         location:nil
                                             date:nil
                                         category:nil
                                     withinRadius:nil
                                     radiusMetric:nil
                                       sortByType:nil
                                    sortDirection:nil
                                         censored:nil];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:query]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               
                               if (error) {
                                   completionblock(nil, error);
                                   return;
                               }
                               
                               NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               NSMutableArray *arr = [NSMutableArray array];
                               for (NSDictionary *dict in [json objectForKey:@"category"]) {
                                   NSDictionary *d = @{@"id" : [dict objectForKey:@"id"],
                                                       @"name" : [[dict objectForKey:@"name"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]};
                                   [arr addObject:d];
                               }
                
                               [arr sortUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"name"  ascending:YES]]];
                               completionblock(arr, nil);
                           }];
    
}

- (NSString *)generateQueryWithType:(NSInteger)type
                           objectId:(NSString *)objectId
                           keywords:(NSString *)keywords
                          geoCoords:(NSDictionary *)coords
                           location:(NSString *)location
                               date:(NSString *)date
                           category:(NSString *)category
                       withinRadius:(id)radius
                       radiusMetric:(NSString *)metric
                         sortByType:(NSString *)sortType
                      sortDirection:(NSString *)direction
                           censored:(BOOL)censored
{
    
    if (objectId) {
        if (type == 0) {
            return [NSString stringWithFormat:@"http://api.eventful.com/json/%@/%@?app_key=%@&id=%@",
                    kJSQueryEvents,
                    kJSQueryGet,
                    self.apiKey,
                    objectId];
        }
        
        if (type == 1) {
            return [NSString stringWithFormat:@"http://api.eventful.com/json/%@/%@?app_key=%@&id=%@",
                    kJSQueryVenues,
                    kJSQueryGet,
                    self.apiKey,
                    objectId];
            
        }
        
        if (type == 2) {
            return [NSString stringWithFormat:@"http://api.eventful.com/json/%@/%@?app_key=%@&id=%@",
                    kJSQueryPerformers,
                    kJSQueryGet,
                    self.apiKey,
                    objectId];
        }
        
        if (type == 3) {
            return [NSString stringWithFormat:@"http://api.eventful.com/json/%@/%@?app_key=%@&id=%@",
                    kJSQueryDemands,
                    kJSQueryGet,
                    self.apiKey,
                    objectId];
        }
    }
    
    
    
    if (type == 0) {
        return [NSString stringWithFormat:@"http://api.eventful.com/json/%@/%@?app_key=%@&keywords=%@&%@&date=%@&category=%@&sort_order=%@&sort_direction=%@&mature=%@&page_number=%ld",
                kJSQueryEvents,
                kJSQuerySearch,
                self.apiKey,
                (keywords) ? [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] : @"",
                (coords) ? [NSString stringWithFormat:@"where=%@,%@&within=%@&metric=%@", coords[@"latitude"], coords[@"longitude"], (radius) ? radius : @"", (metric) ? metric : @""] : [NSString stringWithFormat:@"location=%@", [location stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]],
                (date) ? date : @"",
                (category) ? category : @"",
                (sortType) ? sortType : @"",
                (direction) ? direction : @"",
                (censored) ? @"safe" : @"all",
                (long)self.eventsPageNumber];
    } else if (type == 1) {
        return [NSString stringWithFormat:@"http://api.eventful.com/json/%@/%@?app_key=%@&keywords%@&%@&sort_order=%@&sort_direction=%@&page_number=%li",
                kJSQueryVenues,
                kJSQuerySearch,
                self.apiKey,
                (keywords) ? [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] : @"",
                (coords) ? [NSString stringWithFormat:@"where=%@,%@&within=%@&metric=%@", coords[@"latitude"], coords[@"longitude"], (radius) ? radius : @"", (metric) ? metric : @""] : [NSString stringWithFormat:@"location=%@", [location stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]],
                (sortType) ? sortType : @"",
                (direction) ? direction : @"",
                self.venuesPageNumber];
    } else if (type == 2) {
        return [NSString stringWithFormat:@"http://api.eventful.com/json/%@/%@?app_key=%@&keywords=%@&sort_order=%@&sort_direction=%@&page_number=%li",
                kJSQueryPerformers,
                kJSQuerySearch,
                self.apiKey,
                (keywords) ? [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] : @"",
                (sortType) ? sortType : @"",
                (direction) ? direction : @"",
                self.performersPageNumber];
    } else if (type == 3) {
        return [NSString stringWithFormat:@"http://api.eventful.com/json/%@/%@?app_key=%@&keywords=%@&%@&sort_order=%@&sort_direction=%@&page_number=%li",
                kJSQueryDemands,
                kJSQuerySearch,
                self.apiKey,
                (keywords) ? [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] : @"",
                (coords) ? [NSString stringWithFormat:@"where=%@,%@&within=%@&metric=%@", coords[@"latitude"], coords[@"longitude"], (radius) ? radius : @"", (metric) ? metric : @""] : (location) ? [NSString stringWithFormat:@"location=%@", [location stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] : @"location=",
                (sortType) ? sortType : @"",
                (direction) ? direction : @"",
                self.demandsPageNumber];
    } else if (type == 4) {
        return [NSString stringWithFormat:@"http://api.eventful.com/json/%@/list?app_key=%@", kJSQueryCategories, self.apiKey];
    }
    
    return nil;
}

- (void)JSCurrentLocation:(JSCurrentLocation *)object didFailToReceiveLocation:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(JSEventAPI:didReceiveCurrentLocationError:)]) {
        [self.delegate JSEventAPI:self didReceiveCurrentLocationError:error];
    }
}


- (void)JSCurrentLocation:(JSCurrentLocation *)object didReceiveLocation:(NSDictionary *)location
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(JSEventAPI:didReceiveCurrentLocation:)]) {
        [self.delegate JSEventAPI:self didReceiveCurrentLocation:location];
    }
}

@end
