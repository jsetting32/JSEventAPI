//
//  JSPerformerObject.m
//  Example
//
//  Created by John Setting on 12/5/14.
//  Copyright (c) 2014 John Setting. All rights reserved.
//

#import "JSPerformerObject.h"
#import "JSEventObject.h"

@implementation JSPerformerObject
- (id)initWithData:(NSDictionary *)data
{
    if (!(self = [super init])) return nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.JSPerformerId = data[@"id"];
    self.JSPerformerURL = (![data[@"url"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"url"]) ? data[@"url"] : [NSURL URLWithString:@""];
    self.JSPerformerName = data[@"name"];
    self.JSPerformerIsHuman = (![data[@"is_human"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"is_human"]) ? [NSNumber numberWithInteger:[data[@"is_human"] integerValue]] : [NSNumber numberWithBool:true];
    self.JSPerformerShortBio = (![data[@"short_bio"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"short_bio"]) ? data[@"short_bio"] : @"";
    self.JSPerformerLongBio = (![data[@"long_bio"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"long_bio"]) ? data[@"long_bio"] : @"";
    self.JSPerformerDemandCount = (![data[@"demand_count"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"demand_count"]) ? [NSNumber numberWithInteger:[data[@"demand_count"] integerValue]] : @0;
    self.JSPerformerDemandMemberCount = (![data[@"demand_member_count"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"demand_member_count"]) ? [NSNumber numberWithInteger:[data[@"demand_member_count"] integerValue]] : @0;
    self.JSPerformerEventCount = (![data[@"event_count"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"event_count"]) ? [NSNumber numberWithInteger:[data[@"event_count"] integerValue]] : @0;
    self.JSPerformerCreated = (![data[@"created"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"created"]) ? [formatter dateFromString:data[@"created"]] : @"TBD";
    if (!self.JSPerformerCreated) self.JSPerformerCreated = [NSDate dateWithTimeIntervalSince1970:[data[@"created"] floatValue]];
    self.JSPerformerCreator = (![data[@"creator"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"creator"]) ? data[@"creator"] : @"";
    self.JSPerformerWithdrawn = (![data[@"withdrawn"] isEqual:[NSNull null]] && [[data allKeys] containsObject:@"withdrawn"]) ? [NSNumber numberWithInteger:[data[@"withdrawn"] integerValue]] : [NSNumber numberWithBool:false];
    self.JSPerformerWithdrawnReason = (![data[@"withdrawn_note"] isEqual:[NSNull null]]  && [[data allKeys] containsObject:@"withdrawn_note"]) ? data[@"withdrawn_note"] : @"";
    self.JSPerformerLinker = (![data[@"linker"] isEqual:[NSNull null]]  && [[data allKeys] containsObject:@"linker"]) ? data[@"linker"] : @"";
    
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
        self.JSPerformerLinks = [NSArray arrayWithArray:arr];
    } else {
        self.JSPerformerLinks = [NSArray array];
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
        self.JSPerformerComments = [NSArray arrayWithArray:arr];
    } else {
        self.JSPerformerComments = [NSArray array];
    }
    
    if (![data[@"images"] isEqual:[NSNull null]]) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([data[@"images"][@"image"] isKindOfClass:[NSDictionary class]]) {
            [arr addObject:[[JSPerformerObject alloc] initWithData:data[@"images"][@"image"]]];
        } else {
            for (NSDictionary *dict in data[@"images"][@"image"]) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [arr addObject:dict];
                }
            }
        }
        self.JSPerformerImages = [NSArray arrayWithArray:arr];
    } else {
        self.JSPerformerImages = [NSArray array];
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
        self.JSPerformerTags = [NSArray arrayWithArray:arr];
    } else {
        self.JSPerformerTags = [NSArray array];
    }
    
    if (![data[@"demands"] isEqual:[NSNull null]]) {
        NSMutableArray *arr = [NSMutableArray array];
        if ([data[@"demands"][@"demand"] isKindOfClass:[NSDictionary class]]) {
            [arr addObject:data[@"demands"][@"demand"]];
        } else {
            for (NSDictionary *dict in data[@"demands"][@"demand"]) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [arr addObject:dict];
                }
            }
        }
        self.JSPerformerDemands = [NSArray arrayWithArray:arr];
    } else {
        self.JSPerformerDemands = [NSArray array];
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
        self.JSPerformerEvents = [NSArray arrayWithArray:arr];
    } else {
        self.JSPerformerEvents = [NSArray array];
    }
    
    
    /*
     @property (nonatomic) NSDictionary *objects;
     @property (nonatomic) NSString *JSPerformerId;
     @property (nonatomic) NSString *JSPerformerURL;
     @property (nonatomic) NSString *JSPerformerName;
     @property (nonatomic) BOOL JSPerformerIsHuman;
     @property (nonatomic) NSString *JSPerformerShortBio;
     @property (nonatomic) NSString *JSPerformerLongBio;
     @property (nonatomic) NSNumber *JSPerformerDemandCount;
     @property (nonatomic) NSNumber *JSPerformerDemandMemberCount;
     @property (nonatomic) NSNumber *JSPerformerEventCount;
     @property (nonatomic) id JSPerformerCreated;
     @property (nonatomic) NSString *JSPerformerCreator;
     @property (nonatomic) BOOL JSPerformerWithdrawn;
     @property (nonatomic) NSString *JSPerformerWithdrawnReason;
     @property (nonatomic) NSArray *JSPerformerLinks;
     @property (nonatomic) NSArray *JSPerformerComments;
     @property (nonatomic) NSArray *JSPerformerImages;
     @property (nonatomic) NSArray *JSPerformerTags;
     @property (nonatomic) NSArray *JSPerformerDemands;
     @property (nonatomic) NSArray *JSPerformerEvents;
     */

    self.objects = [NSDictionary dictionaryWithObjects:@[
                                                         self.JSPerformerId,
                                                         self.JSPerformerURL,
                                                         self.JSPerformerName,
                                                         self.JSPerformerIsHuman,
                                                         self.JSPerformerShortBio,
                                                         self.JSPerformerLongBio,
                                                         self.JSPerformerDemandCount,
                                                         self.JSPerformerDemandMemberCount,
                                                         self.JSPerformerEventCount,
                                                         self.JSPerformerCreated,
                                                         self.JSPerformerCreator,
                                                         self.JSPerformerWithdrawn,
                                                         self.JSPerformerWithdrawnReason,
                                                         self.JSPerformerLinks,
                                                         self.JSPerformerLinker,
                                                         self.JSPerformerComments,
                                                         self.JSPerformerImages,
                                                         self.JSPerformerTags,
                                                         self.JSPerformerDemands,
                                                         self.JSPerformerEvents]
                                               forKeys:@[@"id",
                                                         @"url",
                                                         @"name",
                                                         @"isHuman",
                                                         @"shortBio",
                                                         @"longBio",
                                                         @"demandCount",
                                                         @"demandMemberCount",
                                                         @"eventCount",
                                                         @"created",
                                                         @"creator",
                                                         @"withdrawn",
                                                         @"withdrawnReason",
                                                         @"links",
                                                         @"linker",
                                                         @"comments",
                                                         @"images",
                                                         @"tags",
                                                         @"demands",
                                                         @"events"]];
    return self;
}
@end
