//
//  RJRefreshScrollHeaderView.h
//  RefreshScroll
//
//  Created by Youyi Zhang on 13-9-30.
//  Copyright (c) 2013 Youyi Zhang. All rights reserved.
//

#include "RJRefreshState.h"

@class RJRefreshScrollHeaderParameter;

@protocol RJRefreshScrollHeaderDelegate;

/**
 * Pull down to refresh scroll view, such as UITableView or UICollectionView(PSTCollectionView)
 */
@interface RJRefreshScrollHeaderView : UIView

/**
 * The delegate of the RJRefreshScrollHeaderView
 */
@property(nonatomic, assign) id<RJRefreshScrollHeaderDelegate> delegate;

/**
 * Initialize
 * @param frame, The frame of the RJRefreshScrollHeaderView
 * @param parameter, Other initial parameters.
 * @return, self
 */
- (id)initWithFrame:(CGRect)frame parameter:(RJRefreshScrollHeaderParameter *)parameter;

/**
 * Update the last refreshed date, please send "initWithFrame:parameter:" message.
 */
- (void)refreshLastRefreshedDate;
/**
 * Please send this message when scrolling content view.
 * @param scrollview, UITableView or UICollectionView as usual.
 */
- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;
/**
 * Please send this messsage when finished scrolling.
 * @param scrollview, UITableView or UICollectionView as usual.
 */
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
/**
 * Please send this message when finished loading.
 * @param scrollview, UITableView or UICollectionView as usual.
 */
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

/**
 * The delegate of the RJRefreshScrollHeaderView
 */
@protocol RJRefreshScrollHeaderDelegate

/**
 * The "RJRefreshScrollHeaderView" sends this message after began to refresh.
 */
- (void)refreshScrollHeaderDidTriggerRefresh;
/**
 * Whether the scroll view is loading data or not.
 * @return, whether the scroll view is loading data or not.
 */
- (BOOL)refreshScrollHeaderDataSourceIsLoading;

@optional
/**
 * Get the data source update date.
 * @return, The data source update date.
 */
- (NSDate *)refreshScrollHeaderDataSourceLastUpdated;

@end