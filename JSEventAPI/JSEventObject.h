//
//  JSEventObject.h
//  Example
//
//  Created by John Setting on 12/5/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSEventObject : NSObject

- (id)initWithData:(NSDictionary *)data;

@property (nonatomic) NSDictionary *objects;
@property (nonatomic) NSString *JSEventAddress;
@property (nonatomic) NSNumber *JSEventAllDay;
@property (nonatomic) NSString *JSEventCityName;
@property (nonatomic) NSString *JSEventCountry;
@property (nonatomic) id JSEventDateCreated;
@property (nonatomic) NSString *JSEventDescription;
@property (nonatomic) NSNumber *JSEventGoingCount;
@property (nonatomic) NSString *JSEventId;
@property (nonatomic) NSURL *JSEventImage;
@property (nonatomic) NSNumber *JSEventLocationLatitude;
@property (nonatomic) NSNumber *JSEventLocationLongitude;
@property (nonatomic) id JSEventDateModified;
@property (nonatomic) NSString *JSEventOwner;
@property (nonatomic) NSNumber *JSEventZipCode;
@property (nonatomic) NSArray * JSEventPerformers;
@property (nonatomic) NSString *JSEventPrice;
@property (nonatomic) NSNumber *JSEventPrivacy;
@property (nonatomic) NSString *JSEventRegionName;
@property (nonatomic) NSString *JSEventRegionNameAbbreviation;
@property (nonatomic) id JSEventStartTime;
@property (nonatomic) id JSEventEndTime;
@property (nonatomic) NSString *JSEventTitle;
@property (nonatomic) NSURL *JSEventURL;
@property (nonatomic) NSString *JSEventVenueAddress;
@property (nonatomic) NSString *JSEventVenueId;
@property (nonatomic) NSString *JSEventVenueName;
@property (nonatomic) NSURL *JSEventVenueURL;
@property (nonatomic) NSNumber *JSEventWatchingCount;
@end
