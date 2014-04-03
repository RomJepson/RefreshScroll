//
//  RJRefreshScrollParameter.m
//  RefreshScroll
//
//  Created by Rom Jepson on 14-4-3.
//  Copyright (c) 2014年 Youyi Zhang. All rights reserved.
//

#import "RJRefreshScrollParameter.h"

#import "RJUIKit.h"

@implementation RJRefreshScrollParameter

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = RJColorRGB(0xe2, 0xe7, 0xed);
        self.textColor = RJColorRGB(0x57, 0x6c, 0x89);
        self.activityIndicatorColor = self.textColor;
        self.loadingPrompt = @"Loading...";
        self.lastRefreshPrompt = @"Last Updated";
        self.amPrompt = @"AM";
        self.pmPrompt = @"PM";
    }
    return self;
}

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
