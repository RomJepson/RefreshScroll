//
//  RJRefreshScrollHeaderParameter.m
//  RefreshScroll
//
//  Created by Youyi Zhang on 13-10-16.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#import "RJRefreshScrollHeaderParameter.h"

@implementation RJRefreshScrollHeaderParameter

- (id)init {
    self = [super init];
    if (self) {
        self.topDelta = 64.0f;
        self.pullPrompt = @"Pull down to refresh...";
        self.releasePrompt = @"Release to refresh...";
        self.lastRefreshKey = @"updateRefreshKey";
    }
    return self;
}

@end
