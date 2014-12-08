//
//  JSEventObject.m
//  Example
//
//  Created by John Setting on 12/5/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import "JSEventObject.h"
#import "JSPerformerObject.h"

@implementation JSEventObject
- (id)initWithData:(NSDictionary *)data
{
    if (!(self = [super init])) return nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.JSEventAddress = (![data[@"address"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"address"]) ? data[@"address"] : @"";
    self.JSEventAllDay =  ([[data allKeys] containsObject:@"all_day"]) ? [NSNumber numberWithBool:[data[@"all_day"] boolValue]] : [NSNumber numberWithBool:false];
    self.JSEventCityName = (![data[@"city_name"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"city_name"]) ? data[@"city_name"] : @"";
    self.JSEventCountry = (![data[@"country_name"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"country_name"]) ? data[@"country_name"] : @"";
    self.JSEventDateCreated = (![data[@"created"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"created"]) ? [formatter dateFromString:data[@"created"]] : @"TBD";
    self.JSEventDescription = (![data[@"description"] isEqual:[NSNull null]]) ? (([data[@"description"] isEqualToString:@" "]) ? @"No Description" : data[@"description"]) : @"No Description";
    if ([self.JSEventDescription isEqualToString:@" "]) self.JSEventDescription = @"No Description";
    self.JSEventGoingCount = (![data[@"going_count"] isEqual:[NSNull null]]) ? [NSNumber numberWithInt:[data[@"going_count"] intValue]] : [NSNumber numberWithInt:0];
    
    self.JSEventId = data[@"id"];
    self.JSEventImage = (![data[@"image"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"image"]) ? data[@"image"][@"medium"][@"url"] : [NSURL URLWithString:@""];
    if ([[data allKeys] containsObject:@"images"]) {
        self.JSEventImage = (![data[@"images"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"images"]) ? data[@"images"][@"image"][@"medium"][@"url"] : [NSURL URLWithString:@""];
    }
    
    self.JSEventLocationLatitude = [NSNumber numberWithFloat:[data[@"latitude"] floatValue]];
    self.JSEventLocationLongitude = [NSNumber numberWithFloat:[data[@"longitude"] floatValue]];
    self.JSEventDateModified = (![data[@"modified"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"modified"]) ? [formatter dateFromString:data[@"modified"]] : @"TBD";
    self.JSEventOwner = ([[data allKeys] containsObject:@"owner"]) ? data[@"owner"] : @"";
    
    
    
    if (![data[@"performers"] isEqual:[NSNull null]]) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([data[@"performers"][@"performer"] isKindOfClass:[NSDictionary class]]) {
            [arr addObject:[[JSPerformerObject alloc] initWithData:data[@"performers"][@"performer"]]];
        } else {
            for (NSDictionary *dict in data[@"performers"][@"performer"]) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [arr addObject:[[JSPerformerObject alloc] initWithData:dict]];
                }
            }
        }
        self.JSEventPerformers = [NSArray arrayWithArray:arr];
    } else {
        self.JSEventPerformers = [NSArray array];
    }
    
    
    self.JSEventZipCode = (![data[@"postal_code"] isEqual:[NSNull null]]) ? [NSNumber numberWithInt:[data[@"postal_code"] intValue]] : [NSNumber numberWithInt:0];
    self.JSEventPrice = (![data[@"price"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"price"]) ? data[@"price"] : @"TBD";
    self.JSEventPrivacy = [NSNumber numberWithBool:[data[@"privacy"] boolValue]];
    self.JSEventRegionName = (![data[@"region_name"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"region_name"]) ? data[@"region_name"] : @"Unknown";
    self.JSEventRegionNameAbbreviation = (![data[@"region_abbr"] isEqual:[NSNull null]]  && [[data allKeys] containsObject:@"region_abbr"]) ? data[@"region_abbr"] : @"Unknown";
    self.JSEventStartTime = (![data[@"start_time"] isEqual:[NSNull null]]) ? [formatter dateFromString:data[@"start_time"]] : @"TBD";
    self.JSEventEndTime = (![data[@"stop_time"] isEqual:[NSNull null]]) ? [formatter dateFromString:data[@"stop_time"]] : @"TBD";
    self.JSEventTitle = data[@"title"];
    self.JSEventURL = (![data[@"url"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"url"]) ? data[@"url"] : [NSURL URLWithString:@""];
    self.JSEventVenueAddress = (![data[@"venue_address"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"venue_address"]) ? data[@"venue_address"] : @"";
    self.JSEventVenueId = ([[data allKeys] containsObject:@"venue_id"]) ? data[@"venue_id"] : @"";
    self.JSEventVenueName = ([[data allKeys] containsObject:@"venue_name"]) ? data[@"venue_name"] : @"";
    self.JSEventVenueURL = (![data[@"venue_url"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"venue_url"]) ? data[@"venue_url"] : [NSURL URLWithString:@""];
    self.JSEventWatchingCount = (![data[@"watching_count"] isEqual:[NSNull null]]) ? [NSNumber numberWithInt:[data[@"watching_count"] intValue]] : [NSNumber numberWithInt:0];
    
    self.objects = [NSDictionary dictionaryWithObjects:@[self.JSEventAddress,
                                                         self.JSEventAllDay,
                                                         self.JSEventCityName,
                                                         self.JSEventCountry,
                                                         self.JSEventDateCreated,
                                                         self.JSEventDescription,
                                                         self.JSEventGoingCount,
                                                         self.JSEventId,
                                                         self.JSEventImage,
                                                         self.JSEventLocationLatitude,
                                                         self.JSEventLocationLongitude,
                                                         self.JSEventDateModified,
                                                         self.JSEventOwner,
                                                         self.JSEventPerformers,
                                                         self.JSEventPrice,
                                                         self.JSEventZipCode,
                                                         self.JSEventPrivacy,
                                                         self.JSEventRegionName,
                                                         self.JSEventRegionNameAbbreviation,
                                                         self.JSEventStartTime,
                                                         self.JSEventEndTime,
                                                         self.JSEventTitle,
                                                         self.JSEventURL,
                                                         self.JSEventVenueAddress,
                                                         self.JSEventVenueId,
                                                         self.JSEventVenueName,
                                                         self.JSEventVenueURL,
                                                         self.JSEventWatchingCount]
                                               forKeys:@[@"eventAddress",
                                                         @"isAllDay",
                                                         @"cityName",
                                                         @"countryName",
                                                         @"dateCreated",
                                                         @"description",
                                                         @"goingCount",
                                                         @"id",
                                                         @"image",
                                                         @"latitude",
                                                         @"longitude",
                                                         @"dateModified",
                                                         @"owner",
                                                         @"performers",
                                                         @"price",
                                                         @"zipCode",
                                                         @"isPrivate",
                                                         @"regionName",
                                                         @"regionNameAbbreviation",
                                                         @"startTime",
                                                         @"stopTime",
                                                         @"title",
                                                         @"url",
                                                         @"venueAddress",
                                                         @"venueId",
                                                         @"venueName",
                                                         @"venueURL",
                                                         @"watchingCount"]];
    
    return self;
}

@end
