//
//  RJRefreshScrollFooterParameter.m
//  RefreshScroll
//
//  Created by Youyi Zhang on 14-4-3.
//  Copyright (c) 2014年 Youyi Zhang. All rights reserved.
//

#import "RJRefreshScrollFooterParameter.h"

#import "RJUIKit.h"

@implementation RJRefreshScrollFooterParameter

- (id)init {
    self = [super init];
    if (self) {
        self.pullPrompt = @"Pull up to load more...";
        self.releasePrompt = @"Release to load more...";
        self.lastRefreshKey = @"loadMoreRefreshKey";
    }
    return self;
}

@end
