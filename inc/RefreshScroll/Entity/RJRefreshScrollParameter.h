//
//  RJRefreshScrollParameter.h
//  RefreshScroll
//
//  Created by Rom Jepson on 14-4-3.
//  Copyright (c) 2014年 Youyi Zhang. All rights reserved.
//

@interface RJRefreshScrollParameter : NSObject

/**
 * Background color, default color is #e2e7ed.
 */
@property(nonatomic, retain) UIColor *backgroundColor;
/**
 * Text color, consists of status text color and update infor text color.
 * Default color is #576c89.
 */
@property(nonatomic, retain) UIColor *textColor;
/**
 * The activity indicator color, and default color is equal to textColor.
 */
@property(nonatomic, retain) UIColor *activityIndicatorColor;
/**
 * The arrow image file name, 30.0f x 50.0f
 */
@property(nonatomic, copy) NSString *arrowFileName;
/**
 * The "pull" localized string.
 * Default value is "Pull up to load more..." in RJRefreshScrollFooterParameter.
 * Default value is "Pull down to refresh..." in RJRefreshScrollHeaderParameter.
 */
@property(nonatomic, copy) NSString *pullPrompt;
/**
 * The "release" localized string.
 * Default values is "Release to load more..." in RJRefreshScrollFooterParameter.
 * Default values is "Release to refresh..." in RJRefreshScrollHeaderParameter.
 */
@property(nonatomic, copy) NSString *releasePrompt;
/**
 * The "loading" localized string, default value is "Loading...".
 */
@property(nonatomic, copy) NSString *loadingPrompt;
/**
 * The "last refresh" localized string, default value is "Last Updated".
 */
@property(nonatomic, copy) NSString *lastRefreshPrompt;
/**
 * The "last refresh" key, uses for storing in NSUserDefaults,
 * default value is "loadMoreRefreshKey".
 */
@property(nonatomic, copy) NSString *lastRefreshKey;
/**
 * The "am" localized string, default value is "AM".
 */
@property(nonatomic, copy) NSString *amPrompt;
/**
 * The "pm" localized string, default value is "PM".
 */
@property(nonatomic, copy) NSString *pmPrompt;

@end
