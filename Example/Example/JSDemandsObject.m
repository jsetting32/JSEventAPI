//
//  JSDemandsObject.m
//  Example
//
//  Created by John Setting on 12/6/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import "JSDemandsObject.h"
#import "JSPerformerObject.h"
#import "JSEventObject.h"

@implementation JSDemandsObject
- (id)initWithData:(NSDictionary *)data
{
    if (!(self = [super init])) return nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    self.JSDemandId = data[@"id"];
    self.JSDemandDescription = (![data[@"description"] isEqual:[NSNull null]]) ? (([data[@"description"] isEqualToString:@" "]) ? @"No Description" : data[@"description"]) : @"No Description";
    self.JSDemandStatus = data[@"status"];
    self.JSDemandLocation = (![data[@"location"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"location"]) ? data[@"location"] : @"";
    self.JSDemandMemberCount = (![data[@"member_count"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"member_count"]) ? [NSNumber numberWithInteger:[data[@"member_count"] integerValue]] : @0;
    self.JSDemandCreated = (![data[@"created"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"created"]) ? [formatter dateFromString:data[@"created"]] : @"TBD";
    if (!self.JSDemandCreated) self.JSDemandCreated = [NSDate dateWithTimeIntervalSince1970:[data[@"created"] floatValue]];
    self.JSDemandCreator = data[@"creator"];
    self.JSDemandWithdrawn = (![data[@"withdrawn"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"withdrawn"]) ? [NSNumber numberWithInteger:[data[@"withdrawn"] integerValue]] : [NSNumber numberWithBool:false];
    self.JSDemandWithdrawnReason = (![data[@"withdrawn_note"] isEqual:[NSNull null]]  && [[data allKeys] containsObject:@"withdrawn_note"]) ? data[@"withdrawn_note"] : @"";

    self.JSDemandPerformers = (![data[@"performer"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"performer"]) ? [NSArray arrayWithObject:[[JSPerformerObject alloc] initWithData:data[@"performer"]]] : [NSArray array];
    
    if (![data[@"links"] isEqual:[NSNull null]]) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([data[@"links"][@"link"] isKindOfClass:[NSDictionary class]]) {
            [arr addObject:data[@"links"][@"link"]];
        } else {
            for (NSDictionary *dict in data[@"links"][@"link"]) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [arr addObject:dict];
                }
            }
        }
        self.JSDemandLinks = [NSArray arrayWithArray:arr];
    } else {
        self.JSDemandLinks = [NSArray array];
    }
    
    if (![data[@"comments"] isEqual:[NSNull null]]) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([data[@"comments"][@"comment"] isKindOfClass:[NSDictionary class]]) {
            [arr addObject:data[@"comments"][@"comment"]];
        } else {
            for (NSDictionary *dict in data[@"comments"][@"comment"]) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [arr addObject:dict];
                }
            }
        }
        self.JSDemandComments = [NSArray arrayWithArray:arr];
    } else {
        self.JSDemandComments = [NSArray array];
    }
    
    self.JSDemandCommentCount = (![data[@"comment_count"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"comment_count"]) ? [NSNumber numberWithInteger:[data[@"comment_count"] integerValue]] : [NSNumber numberWithInteger:[self.JSDemandComments count]];

    
    if (![data[@"images"] isEqual:[NSNull null]]) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([data[@"images"][@"image"] isKindOfClass:[NSDictionary class]]) {
            [arr addObject:data[@"images"][@"image"]];
        } else {
            for (NSDictionary *dict in data[@"images"][@"image"]) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [arr addObject:dict];
                }
            }
        }
        self.JSDemandImages = [NSArray arrayWithArray:arr];
    } else {
        self.JSDemandImages = [NSArray array];
    }
    
    if (![data[@"tags"] isEqual:[NSNull null]]) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([data[@"tags"][@"tag"] isKindOfClass:[NSDictionary class]]) {
            [arr addObject:data[@"tags"][@"tag"]];
        } else {
            for (NSDictionary *dict in data[@"tags"][@"tag"]) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [arr addObject:dict];
                }
            }
        }
        self.JSDemandTags = [NSArray arrayWithArray:arr];
    } else {
        self.JSDemandTags = [NSArray array];
    }
    
    if (![data[@"events"] isEqual:[NSNull null]]) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([data[@"events"][@"event"] isKindOfClass:[NSDictionary class]]) {
            [arr addObject:[[JSEventObject alloc] initWithData:data[@"events"][@"event"]]];
        } else {
            for (NSDictionary *dict in data[@"events"][@"event"]) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [arr addObject:[[JSEventObject alloc] initWithData:dict]];
                }
            }
        }
        self.JSDemandEvents = [NSArray arrayWithArray:arr];
    } else {
        self.JSDemandEvents = [NSArray array];
    }
    
    self.objects = [NSDictionary dictionaryWithObjects:@[self.JSDemandId,
                                                         self.JSDemandDescription,
                                                         self.JSDemandStatus,
                                                         self.JSDemandLocation,
                                                         self.JSDemandMemberCount,
                                                         self.JSDemandCreated,
                                                         self.JSDemandCreator,
                                                         self.JSDemandWithdrawn,
                                                         self.JSDemandWithdrawnReason,
                                                         self.JSDemandPerformers,
                                                         self.JSDemandLinks,
                                                         self.JSDemandComments,
                                                         self.JSDemandCommentCount,
                                                         self.JSDemandImages,
                                                         self.JSDemandTags,
                                                         self.JSDemandEvents]
                                               forKeys:@[@"id",
                                                         @"description",
                                                         @"status",
                                                         @"location",
                                                         @"memberCount",
                                                         @"created",
                                                         @"creator",
                                                         @"withdrawn",
                                                         @"withdrawnReason",
                                                         @"performers",
                                                         @"links",
                                                         @"comments",
                                                         @"commentCount",
                                                         @"images",
                                                         @"tags",
                                                         @"events"]];
    return self;
}

@end
