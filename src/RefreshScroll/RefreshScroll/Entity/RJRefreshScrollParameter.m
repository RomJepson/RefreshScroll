//
//  RJRefreshScrollParameter.m
//  RefreshScrollDemo
//
//  Created by Youyi Zhang on 13-10-16.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#import "RJRefreshScrollParameter.h"

@implementation RJRefreshScrollParameter

- (void)dealloc {
    self.backgroundColor = nil;
    self.textColor = nil;
    self.activityIndicatorColor = nil;
    self.arrowFileName = nil;
    self.pullPrompt = nil;
    self.releasePrompt = nil;
    self.loadingPrompt = nil;
    self.lastRefreshPrompt = nil;
    self.lastRefreshKey = nil;
    self.amPrompt = nil;
    self.pmPrompt = nil;
    [super dealloc];
}

@end
