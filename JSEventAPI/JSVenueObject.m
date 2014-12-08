//
//  JSVenueObject.m
//  Example
//
//  Created by John Setting on 12/6/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import "JSVenueObject.h"
#import "JSEventObject.h"

@implementation JSVenueObject

- (id)initWithData:(NSDictionary *)data
{
    if (!(self = [super init])) return nil;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.JSVenueId = data[@"id"];
    self.JSVenueURL = data[@"url"];
    self.JSVenueName = data[@"name"];
    self.JSVenueDescription = (![data[@"description"] isEqual:[NSNull null]]) ? (([data[@"description"] isEqualToString:@" "]) ? @"No Description" : data[@"description"]) : @"No Description";
    self.JSVenueType = data[@"venue_type"];
    self.JSVenueAddress = (![data[@"address"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"address"]) ? data[@"address"] : @"Unknown";
    self.JSVenueCity =  (![data[@"city"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"city"]) ? data[@"city"] : @"Unknown";
    self.JSVenueCity =  (![data[@"city_name"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"city_name"]) ? data[@"city_name"] : @"Unknown";
    self.JSVenueRegion =  (![data[@"region"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"region"]) ? data[@"region"] : @"Unknown";
    self.JSVenueRegionAbbreviation = data[@"region_abbr"];
    self.JSVenueZipCode = data[@"postal_code"];
    self.JSVenueCountry = (![data[@"country"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"country"]) ? data[@"country"] : @"Unknown";
    self.JSVenueCountry = (![data[@"country_name"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"country_name"]) ? data[@"country_name"] : @"Unknown";
    self.JSVenueCountryAbbreviation = data[@"country_abbr"];
    self.JSVenueLocationLatitude = data[@"latitude"];
    self.JSVenueLocationLongitude = data[@"longitude"];
    self.JSVenueDateCreated = (![data[@"created"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"created"]) ? [formatter dateFromString:data[@"created"]] : @"TBD";
    self.JSVenueOwner = data[@"owner"];
    self.JSVenueEventCount = (![data[@"event_count"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"event_count"]) ? [NSNumber numberWithInteger:[data[@"event_count"] integerValue]] : @0;
    
    if (![data[@"events"] isEqual:[NSNull null]]) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in [data[@"events"] objectForKey:@"event"]) {
            if ([dict isKindOfClass:[NSDictionary class]]) {
                JSEventObject *event = [[JSEventObject alloc] initWithData:dict];
                [arr addObject:event];
            }
        }
        self.JSVenueEvents = [NSArray arrayWithArray:arr];
    }
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in data[@"images"][@"image"]) {
        [array addObject:dict[@"medium"][@"url"]];
    }
    self.JSVenueImages = [NSArray arrayWithArray:array];

    self.objects = [NSDictionary dictionaryWithObjects:@[self.JSVenueId,
                                                         self.JSVenueURL,
                                                         self.JSVenueName,
                                                         self.JSVenueDescription,
                                                         self.JSVenueType,
                                                         self.JSVenueAddress,
                                                         self.JSVenueCity,
                                                         self.JSVenueRegion,
                                                         self.JSVenueRegionAbbreviation,
                                                         self.JSVenueZipCode,
                                                         self.JSVenueCountry,
                                                         self.JSVenueCountryAbbreviation,
                                                         self.JSVenueLocationLatitude,
                                                         self.JSVenueLocationLongitude,
                                                         self.JSVenueDateCreated,
                                                         self.JSVenueOwner,
                                                         self.JSVenueEvents,
                                                         self.JSVenueEventCount,
                                                         self.JSVenueImages]
                                               forKeys:@[@"id",
                                                         @"url",
                                                         @"name",
                                                         @"description",
                                                         @"type",
                                                         @"address",
                                                         @"city",
                                                         @"region",
                                                         @"regionAbbreviation",
                                                         @"zipCode",
                                                         @"country",
                                                         @"countryAbbreviation",
                                                         @"latitude",
                                                         @"longitude",
                                                         @"created",
                                                         @"owner",
                                                         @"events",
                                                         @"eventCount",
                                                         @"images"]];
    return self;
}

@end
