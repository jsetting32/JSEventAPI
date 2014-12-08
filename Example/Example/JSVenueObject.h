//
//  JSVenueObject.h
//  Example
//
//  Created by John Setting on 12/6/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSVenueObject : NSObject

- (id)initWithData:(NSDictionary *)data;

@property (nonatomic) NSDictionary *objects;
@property (nonatomic) NSString *JSVenueId;
@property (nonatomic) NSURL *JSVenueURL;
@property (nonatomic) NSString *JSVenueName;
@property (nonatomic) NSString *JSVenueDescription;
@property (nonatomic) NSString *JSVenueType;
@property (nonatomic) NSString *JSVenueAddress;
@property (nonatomic) NSString *JSVenueCity;
@property (nonatomic) NSString *JSVenueRegion;
@property (nonatomic) NSString *JSVenueRegionAbbreviation;
@property (nonatomic) NSString *JSVenueZipCode;
@property (nonatomic) NSString *JSVenueCountry;
@property (nonatomic) NSString *JSVenueCountryAbbreviation;
@property (nonatomic) NSString *JSVenueLocationLatitude;
@property (nonatomic) NSString *JSVenueLocationLongitude;
@property (nonatomic) id JSVenueDateCreated;
@property (nonatomic) NSString *JSVenueOwner;
@property (nonatomic) NSArray *JSVenueEvents;
@property (nonatomic) NSNumber *JSVenueEventCount;
@property (nonatomic) NSArray *JSVenueImages;
@end
