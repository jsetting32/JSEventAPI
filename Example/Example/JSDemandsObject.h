//
//  JSDemandsObject.h
//  Example
//
//  Created by John Setting on 12/6/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSDemandsObject : NSObject
- (id)initWithData:(NSDictionary *)data;

@property (nonatomic) NSDictionary *objects;
@property (nonatomic) NSString *JSDemandId;
@property (nonatomic) NSString *JSDemandDescription;
@property (nonatomic) NSString *JSDemandStatus;
@property (nonatomic) NSString *JSDemandLocation;
@property (nonatomic) NSNumber *JSDemandMemberCount;
@property (nonatomic) id JSDemandCreated;
@property (nonatomic) NSString *JSDemandCreator;
@property (nonatomic) NSNumber *JSDemandWithdrawn;
@property (nonatomic) NSString *JSDemandWithdrawnReason;
@property (nonatomic) NSArray *JSDemandPerformers;
@property (nonatomic) NSArray *JSDemandLinks;
@property (nonatomic) NSArray *JSDemandComments;
@property (nonatomic) NSNumber *JSDemandCommentCount;
@property (nonatomic) NSArray *JSDemandImages;
@property (nonatomic) NSArray *JSDemandTags;
@property (nonatomic) NSArray *JSDemandEvents;
@end
