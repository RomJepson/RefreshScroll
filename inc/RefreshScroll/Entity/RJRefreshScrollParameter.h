//
//  RJRefreshScrollParameter.h
//  RefreshScrollDemo
//
//  Created by Youyi Zhang on 13-10-16.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * The "RJRefreshScrollHeaderView" or "RJRefreshScrollFooterView" initial parameters.
 */
@interface RJRefreshScrollParameter : NSObject

/**
 * The top delta.
 */
@property(nonatomic, assign) float topDelta;
/**
 * The bottom delta.
 */
@property(nonatomic, assign) float bottomDelta;
/**
 * Background color.
 */
@property(nonatomic, retain) UIColor *backgroundColor;
/**
 * Text color, consists of status text color and update infor text color.
 */
@property(nonatomic, retain) UIColor *textColor;
/**
 * The activity indicator color.
 */
@property(nonatomic, retain) UIColor *activityIndicatorColor;
/**
 * The arrow image file name, 30.0f x 50.0f
 */
@property(nonatomic, copy) NSString *arrowFileName;
/**
 * The "pull" localized string
 */
@property(nonatomic, copy) NSString *pullPrompt;
/**
 * The "release" localized string
 */
@property(nonatomic, copy) NSString *releasePrompt;
/**
 * The "loading" localized string
 */
@property(nonatomic, copy) NSString *loadingPrompt;
/**
 * The "last refresh" localized string
 */
@property(nonatomic, copy) NSString *lastRefreshPrompt;
/**
 * The "last refresh" key, uses for storing in NSUserDefaults
 */
@property(nonatomic, copy) NSString *lastRefreshKey;
/**
 * The "am" localized string
 */
@property(nonatomic, copy) NSString *amPrompt;
/**
 * The "pm" localized string
 */
@property(nonatomic, copy) NSString *pmPrompt;

@end
