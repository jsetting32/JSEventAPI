//
//  JSPerformerObject.h
//  Example
//
//  Created by John Setting on 12/5/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSPerformerObject : NSObject
- (id)initWithData:(NSDictionary *)data;

@property (nonatomic) NSDictionary *objects;
@property (nonatomic) NSString *JSPerformerId;
@property (nonatomic) NSURL *JSPerformerURL;
@property (nonatomic) NSString *JSPerformerName;
@property (nonatomic) NSNumber *JSPerformerIsHuman;
@property (nonatomic) NSString *JSPerformerShortBio;
@property (nonatomic) NSString *JSPerformerLongBio;
@property (nonatomic) NSNumber *JSPerformerDemandCount;
@property (nonatomic) NSNumber *JSPerformerDemandMemberCount;
@property (nonatomic) NSNumber *JSPerformerEventCount;
@property (nonatomic) id JSPerformerCreated;
@property (nonatomic) NSString *JSPerformerCreator;
@property (nonatomic) NSNumber *JSPerformerWithdrawn;
@property (nonatomic) NSString *JSPerformerWithdrawnReason;
@property (nonatomic) NSString *JSPerformerLinker;
@property (nonatomic) NSArray *JSPerformerLinks;
@property (nonatomic) NSArray *JSPerformerComments;
@property (nonatomic) NSArray *JSPerformerImages;
@property (nonatomic) NSArray *JSPerformerTags;
@property (nonatomic) NSArray *JSPerformerDemands;
@property (nonatomic) NSArray *JSPerformerEvents;
@end
